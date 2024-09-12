import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryTextField extends StatefulWidget {
  final String? hintText;
  final String? helperText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final int? maxLines;
  final int? maxLength;
  final bool isPasswordField;
  final bool enabled;
  final bool readOnly;
  final TextAlign textAlign;
  final TextInputType? keyboardType;
  final TextStyle? textStyle;
  final TextStyle? errorStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? helperStyle;
  final InputDecoration? decoration;
  final ValueChanged<String>? onChanged;
  final Color? borderColor;
  final Color? fillColor;
  final Color? hintColor;
  final Color? cursorColor;
  final Color? errorColor;
  final String? labelText;
  final FocusNode? focusNode;
  final TextCapitalization textCapitalization;
  final bool autoCorrect;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? margin;
  final bool withBorder;

  const PrimaryTextField({
    super.key,
    this.hintText,
    this.controller,
    this.isPasswordField = false,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.enabled = true,
    this.readOnly = false,
    this.textAlign = TextAlign.start,
    this.keyboardType,
    this.textStyle,
    this.errorStyle,
    this.labelStyle,
    this.hintStyle,
    this.helperStyle,
    this.decoration,
    this.onChanged,
    this.borderColor,
    this.maxLines = 1,
    this.labelText,
    this.fillColor,
    this.hintColor,
    this.cursorColor,
    this.errorColor,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.autoCorrect = true,
    this.inputFormatters,
    this.contentPadding =  const EdgeInsets.symmetric(vertical: 18, horizontal: 12), // Increased height
    this.margin,
    this.helperText, this.withBorder=true,
  });

  @override
  _PrimaryTextFieldState createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  bool obscure = false;
  late OutlineInputBorder border;

  @override
  void initState() {
    super.initState();
    obscure = widget.isPasswordField;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: TextFormField(
        cursorColor: widget.cursorColor ?? Colors.deepPurpleAccent,
        enabled: widget.enabled,
        controller: widget.controller,
        readOnly: widget.readOnly,
        focusNode: widget.focusNode,
        minLines: widget.maxLines,
        maxLines: widget.isPasswordField ? 1 : widget.maxLines,
        obscureText: widget.isPasswordField ? obscure : false,
        maxLength: widget.maxLength,
        textAlign: widget.textAlign,
        keyboardType: widget.keyboardType,
        textCapitalization: widget.textCapitalization,
        autocorrect: widget.autoCorrect,
        inputFormatters: widget.inputFormatters,
        onChanged: widget.onChanged,
        style: widget.textStyle ?? TextStyle(fontSize: 14, color: Colors.black87),
        decoration: widget.decoration?.copyWith(
          filled: widget.fillColor != null, // Set filled to true only if fillColor is provided
          isDense: true,
          fillColor: widget.enabled
              ? widget.fillColor // Use fillColor only if provided
              : Colors.grey.shade200,
          counterText: '',
          contentPadding: widget.contentPadding,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle ?? TextStyle(color: Colors.grey.shade500, fontSize: 14),
          labelText: widget.labelText,
          labelStyle: widget.labelStyle ?? TextStyle(color: Colors.grey.shade700, fontSize: 12),
          floatingLabelStyle: TextStyle(color: widget.errorColor ?? Colors.redAccent),
          helperText: widget.helperText,
          helperStyle: widget.helperStyle ?? TextStyle(color: Colors.grey.shade600, fontSize: 12),
          prefixIconConstraints: const BoxConstraints(minWidth: 30, maxHeight: 30),
          prefixIcon: widget.prefixIcon,
          suffixIconConstraints: const BoxConstraints(minWidth: 30, maxHeight: 30),
          suffixIcon: widget.isPasswordField
              ? IconButton(
            splashRadius: 20,
            icon: obscure
                ? Icon(Icons.visibility, color: Colors.blueAccent, size: 20)
                : Icon(Icons.visibility_off, color: Colors.redAccent, size: 20),
            onPressed: () {
              setState(() {
                obscure = !obscure;
              });
            },
          )
              : widget.suffixIcon,
          errorStyle: widget.errorStyle ?? TextStyle(color: Colors.redAccent, fontSize: 12),
          border: widget.withBorder
              ? OutlineInputBorder()
              : UnderlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor ?? Colors.grey.shade400),
          ),
          enabledBorder: widget.withBorder
              ? OutlineInputBorder()
              : UnderlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor ?? Colors.grey.shade400),
          ),
          focusedBorder: widget.withBorder
              ? OutlineInputBorder()
              : UnderlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor ?? Colors.blueAccent),
          ),
          errorBorder: widget.withBorder
              ? OutlineInputBorder()
              : UnderlineInputBorder(
            borderSide: BorderSide(color: widget.errorColor ?? Colors.redAccent),
          ),
          disabledBorder: widget.withBorder
              ? OutlineInputBorder()
              : UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedErrorBorder: widget.withBorder
              ? OutlineInputBorder()
              : UnderlineInputBorder(
            borderSide: BorderSide(color: widget.errorColor ?? Colors.redAccent),
          ),
        ) ??
            InputDecoration(
              filled: widget.fillColor != null, // Set filled to true only if fillColor is provided
              isDense: true,
              fillColor: widget.enabled
                  ? widget.fillColor
                  : Colors.grey.shade200,
              counterText: '',
              contentPadding: widget.contentPadding,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ?? TextStyle(color: Colors.grey.shade500, fontSize: 14),
              labelText: widget.labelText,
              labelStyle: widget.labelStyle ?? TextStyle(color: Colors.grey.shade700, fontSize: 12),
              floatingLabelStyle: TextStyle(color: widget.errorColor ?? Colors.redAccent),
              helperText: widget.helperText,
              helperStyle: widget.helperStyle ?? TextStyle(color: Colors.grey.shade600, fontSize: 12),
              prefixIconConstraints: const BoxConstraints(minWidth: 30, maxHeight: 30),
              prefixIcon: widget.prefixIcon,
              suffixIconConstraints: const BoxConstraints(minWidth: 30, maxHeight: 30),
              suffixIcon: widget.isPasswordField
                  ? IconButton(
                splashRadius: 20,
                icon: obscure
                    ? Icon(Icons.visibility, color: Colors.blueAccent, size: 20)
                    : Icon(Icons.visibility_off, color: Colors.redAccent, size: 20),
                onPressed: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
              )
                  : widget.suffixIcon,
              errorStyle: widget.errorStyle ?? TextStyle(color: Colors.redAccent, fontSize: 12),
              border: widget.withBorder
                  ? OutlineInputBorder()
                  : UnderlineInputBorder(
                borderSide: BorderSide(color: widget.borderColor ?? Colors.grey.shade400),
              ),
              enabledBorder: widget.withBorder
                  ? OutlineInputBorder()
                  : UnderlineInputBorder(
                borderSide: BorderSide(color: widget.borderColor ?? Colors.grey.shade400),
              ),
              focusedBorder: widget.withBorder
                  ? OutlineInputBorder()
                  : UnderlineInputBorder(
                borderSide: BorderSide(color: widget.borderColor ?? Colors.blueAccent),
              ),
              errorBorder: widget.withBorder
                  ? OutlineInputBorder()
                  : UnderlineInputBorder(
                borderSide: BorderSide(color: widget.errorColor ?? Colors.redAccent),
              ),
              disabledBorder: widget.withBorder
                  ? OutlineInputBorder()
                  : UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedErrorBorder: widget.withBorder
                  ? OutlineInputBorder()
                  : UnderlineInputBorder(
                borderSide: BorderSide(color: widget.errorColor ?? Colors.redAccent),
              ),
            ),
        validator: widget.validator,
      ),
    );
  }

}




class CustomTextFormField extends StatelessWidget {
  final Widget? leadingWidget;
  final String? hintText;
  final TextStyle hintStyle;
  final TextEditingController? controller;
  final BoxDecoration? boxDecoration;
  final TextInputType keyboardType;
  final double? width;

  const CustomTextFormField({super.key,
     this.leadingWidget,
    this.hintText, // Default hintText
    this.hintStyle = const TextStyle(color: Colors.white24), // Default hintStyle
    this.controller,
    this.boxDecoration,
    this.keyboardType = TextInputType.text, this.width, // Default keyboard type to phone
  });

  @override
  Widget build(BuildContext context) {
    return Container(
       width:width?? double.infinity,
      height: 50,
       padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: boxDecoration ??
          BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: RadialGradient(
              colors: [
                Color(0xFFFFFFFF).withOpacity(0.1),
                Color(0xFFFFFFFF).withOpacity(0.0224),
                Color(0xFFFFFFFF).withOpacity(0.0),
              ],
              radius: 8.0,
            ),
            border: Border.all(
              color: Colors.white70,
              width: 1,
            ),
          ),
      child: Row(
        children: [
          if(leadingWidget!=null)
          leadingWidget!, // The leading widget (icon, dropdown, etc.)
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              keyboardType: keyboardType,
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: hintStyle,
                border: InputBorder.none, // Remove default border
              ),
              style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

