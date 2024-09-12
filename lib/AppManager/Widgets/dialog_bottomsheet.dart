import 'package:flutter/material.dart';

class ShowModalBottomSheet extends StatelessWidget {
  final Widget child;
  final double? height;
  final String? title;
  final bool isDismissible;
  final bool enableDrag;
  final VoidCallback? onDismiss;
  final Color backgroundColor;

  const ShowModalBottomSheet({super.key,
    required this.child,
    this.height,
    this.title,
    this.isDismissible = true,
    this.enableDrag = true,
    this.onDismiss,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 300),
      curve: Curves.decelerate,
      child: Container(
        height: height,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Flexible(child: child),
          ],
        ),
      ),
    );
  }
}

void showCustomBottomSheet({
  required BuildContext context,
  required Widget content,
  String? title,
  double? height,
  bool isDismissible = true,
  bool enableDrag = true,
  VoidCallback? onDismiss,
  Color backgroundColor = Colors.white,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    builder: (context) => ShowModalBottomSheet(
      title: title,
      height: height,
      onDismiss: onDismiss,
      backgroundColor: backgroundColor,
      child: content,
    ),
  ).whenComplete(() {
    if (onDismiss != null) {
      onDismiss();
    }
  });
}