import 'package:azan/AppManager/Constants/app_colors.dart';
import 'package:flutter/material.dart';

class OTPTextField extends StatefulWidget {
  final int length;
  final ValueChanged<String> onCompleted;

  const OTPTextField({
    super.key,
    this.length = 6,
    required this.onCompleted,
  });

  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  List<String> _otpValues = [];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
    _otpValues = List.generate(widget.length, (_) => "");

    for (int i = 0; i < widget.length; i++) {
      _controllers[i].addListener(() {
        _handleBackspace(i);
      });
    }
  }

  void _onKeyDown(String value, int index) {
    if (value.isNotEmpty) {
      _otpValues[index] = value;

      if (index == widget.length - 1) {
        widget.onCompleted(_otpValues.join());
      } else {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      }
    }
  }

  void _handleBackspace(int index) {
    if (_controllers[index].text.isEmpty && _otpValues[index].isNotEmpty) {
      // Move focus to the previous field on backspace
      if (index > 0) {
        FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
      }
    }
    _otpValues[index] = _controllers[index].text;
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    _focusNodes.forEach((focusNode) => focusNode.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(widget.length, (index) {
        return SizedBox(
          width: 50,
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColor.white),
            decoration: InputDecoration(
              counterText: "",
              contentPadding: const EdgeInsets.all(15),
              // Padding: 15px
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Colors.white70, width: 1),
                // Border: 1px
                borderRadius: BorderRadius.circular(
                    10), // Radius: 10px
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: AppColor.mustardColor, width: 1),
                // Focused border remains same
                borderRadius: BorderRadius.circular(
                    10), // Radius: 10px
              ),
              fillColor: Colors.black12,
              // Color: #FFFFFF (100%)
              filled: true,
            ),
            maxLength: 1,
            keyboardType: TextInputType.number,
            onChanged: (value) => _onKeyDown(value, index),
            inputFormatters: [
              // Add any necessary input formatters (e.g., to allow only numeric inputs)
            ],
          ),
        );
      }),
    );
  }
}
