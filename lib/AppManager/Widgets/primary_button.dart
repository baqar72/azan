import 'package:azan/AppManager/Constants/app_colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? leading;
  final Widget? trailing;
  final Color? borderColor;
  final Color? textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double borderRadius;
  final EdgeInsets padding;
  final double? width;
  final double? height;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.leading,
    this.trailing,
    this.borderColor,
    this.textColor = Colors.white,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w500,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.width,
    this.height=50,
  });

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: widget.width??double.infinity,
          height: widget.height,
          padding: widget.padding,
          decoration: BoxDecoration(
            color: AppColor.mustardColor,
            // gradient:  LinearGradient(colors: [
            //   Colors.black,
            //   Colors.grey,
            //   Colors.black,
            //   // Colors.green
            // ]),
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.leading != null) widget.leading!,
              SizedBox(width: widget.leading != null ? 8.0 : 0),
              Text(
                widget.text,textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: widget.fontSize,
                  fontWeight: widget.fontWeight,
                  color: widget.textColor,
                ),
              ),
              SizedBox(width: widget.trailing != null ? 8.0 : 0),
              if (widget.trailing != null) widget.trailing!,
            ],
          ),
        ),
      ),
    );
  }
}