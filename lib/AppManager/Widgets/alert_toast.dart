// import 'package:flutter/material.dart';
//
// class CustomToast extends StatefulWidget {
//   final String message;
//   final IconData? icon;
//   final Duration duration;
//   final VoidCallback onDismiss;
//
//   const CustomToast({
//     super.key,
//     required this.message,
//     this.icon,
//     required this.duration,
//     required this.onDismiss,
//   });
//
//   @override
//   _CustomToastState createState() => _CustomToastState();
// }
//
// class _CustomToastState extends State<CustomToast> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//     _fadeAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     );
//
//     // Start the fade-in animation
//     _controller.forward();
//
//     // Automatically dismiss the toast after the specified duration
//     Future.delayed(widget.duration, () {
//       _controller.reverse().then((_) => widget.onDismiss());
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FadeTransition(
//       opacity: _fadeAnimation,
//       child: Material(
//         color: Colors.transparent,
//         child: Center(
//           child: Container(
//             margin: const EdgeInsets.symmetric(horizontal: 20.0),
//             padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
//             decoration: BoxDecoration(
//               color: Colors.black.withOpacity(0.7),
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 if (widget.icon != null)
//                   Icon(
//                     widget.icon,
//                     color: Colors.white,
//                     size: 24.0,
//                   ),
//                 if (widget.icon != null) const SizedBox(width: 8.0),
//                 Expanded(
//                   child: Text(
//                     widget.message,
//                     style: const TextStyle(color: Colors.white, fontSize: 16.0),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// enum ToastPosition { top, center, bottom }
//
// void showCustomToast(BuildContext context, String message, {
//   IconData? icon,
//   Duration duration = const Duration(seconds: 2),
//   ToastPosition position = ToastPosition.bottom,
// }) {
//   late OverlayEntry overlayEntry;  // Declare it as late so we can reference it later
//    overlayEntry = OverlayEntry(
//     builder: (context) {
//       double topOffset;
//       switch (position) {
//         case ToastPosition.top:
//           topOffset = MediaQuery.of(context).size.height * 0.1;
//           break;
//         case ToastPosition.center:
//           topOffset = MediaQuery.of(context).size.height * 0.45;
//           break;
//         case ToastPosition.bottom:
//         default:
//           topOffset = MediaQuery.of(context).size.height * 0.8;
//       }
//
//       return Positioned(
//         top: topOffset,
//         left: MediaQuery.of(context).size.width * 0.1,
//         width: MediaQuery.of(context).size.width * 0.8,
//         child: CustomToast(
//           message: message,
//           icon: icon,
//           duration: duration,
//           onDismiss: () {
//             overlayEntry.remove();
//           },
//         ),
//       );
//     },
//   );
//
//   // Insert the overlay
//   Overlay.of(context).insert(overlayEntry);
// }


import 'package:azan/main.dart';
import 'package:flutter/material.dart';

class ToastManager {
  static final ToastManager _instance = ToastManager._internal();

  factory ToastManager() => _instance;

  ToastManager._internal();

  OverlayEntry? _overlayEntry;

  void showToast({
    required String message,
    IconData? icon,
    Duration duration = const Duration(seconds: 2),
    ToastPosition position = ToastPosition.bottom,
  }) {
    _overlayEntry?.remove(); // Remove any existing toast
    _overlayEntry = _createOverlayEntry(message: message, icon: icon, duration: duration, position: position);

    final overlay = AppGlobals.navigatorKey.currentState?.overlay;
    if (overlay != null) {
      overlay.insert(_overlayEntry!); // Insert the new overlay entry
    }
  }

  OverlayEntry _createOverlayEntry({
    required String message,
    IconData? icon,
    required Duration duration,
    ToastPosition position = ToastPosition.bottom,
  }) {
    double topOffset;
    final context = AppGlobals.navigatorKey.currentContext!; // Use the navigator's context

    switch (position) {
      case ToastPosition.top:
        topOffset = MediaQuery.of(context).size.height * 0.1;
        break;
      case ToastPosition.center:
        topOffset = MediaQuery.of(context).size.height * 0.45;
        break;
      case ToastPosition.bottom:
      default:
        topOffset = MediaQuery.of(context).size.height * 0.8;
    }

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: topOffset,
          left: MediaQuery.of(context).size.width * 0.1,
          width: MediaQuery.of(context).size.width * 0.8,
          child: CustomToast(
            message: message,
            icon: icon,
            duration: duration,
            onDismiss: () {
              _overlayEntry?.remove();
              _overlayEntry = null;
            },
          ),
        );
      },
    );
  }
}

class CustomToast extends StatefulWidget {
  final String message;
  final IconData? icon;
  final Duration duration;
  final VoidCallback onDismiss;

  const CustomToast({
    super.key,
    required this.message,
    this.icon,
    required this.duration,
    required this.onDismiss,
  });

  @override
  _CustomToastState createState() => _CustomToastState();
}

class _CustomToastState extends State<CustomToast> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Start the fade-in animation
    _controller.forward();

    // Automatically dismiss the toast after the specified duration
    Future.delayed(widget.duration, () {
      _controller.reverse().then((_) => widget.onDismiss());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.icon != null)
                  Icon(
                    widget.icon,
                    color: Colors.white,
                    size: 24.0,
                  ),
                if (widget.icon != null) const SizedBox(width: 8.0),
                Flexible(
                  child: Text(
                    widget.message,
                    style: const TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum ToastPosition { top, center, bottom }


