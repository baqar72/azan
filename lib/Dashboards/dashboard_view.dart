// import 'package:azan/AppManager/Widgets/alert_toast.dart';
// import 'package:azan/Authentication/LogIn/new_log.dart';
// import 'package:azan/Dashboard/dashboard_controller.dart';
// import 'package:azan/auth_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class DashboardView extends StatelessWidget {
//   const DashboardView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     DashboardController controller = Get.put(DashboardController());
//      final AuthController authController = Get.find<AuthController>();
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(onPressed: () {
//           Get.to(()=>LoginSignupScreen());
//           ToastManager().showToast(
//             message: 'This is a toast!',
//             icon: Icons.check_circle,
//           );
//           // showCustomToast(
//           //   context,
//           //   'This is a custom toast with an icon!',
//           // );
//           controller.hitAzanTiming();
//           // final user = objectBoxService.getUserByUid(authController.currentUser!.uid);
//           // print("name ${user!.name}");
//           // authController.logout();
//         }, child: Text('Logout'),),
//       ),
//     );
//   }
// }
