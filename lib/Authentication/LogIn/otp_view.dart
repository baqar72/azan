import 'package:azan/AppManager/Constants/app_colors.dart';
import 'package:azan/AppManager/Constants/text_theme.dart';
import 'package:azan/AppManager/Widgets/otp_fields.dart';
import 'package:azan/auth_controller.dart';
import 'package:flutter/material.dart';

class OtpPage extends StatelessWidget {
  final String phoneNumber;
  final AuthController authController;

  const OtpPage({super.key, required this.phoneNumber, required this.authController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verify your Account',
          style:
          context.text22!.copyWith(color: AppColor.white),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Please enter the 6 Digits verification code sent to $phoneNumber",
          style: context.text12
              ?.copyWith(color: AppColor.mustardColor),
        ),
        const SizedBox(
          height: 50,
        ),
        Center(
            child: OTPTextField(onCompleted: (String value) {
              print("value $value");
              authController.changePage('signup');
            },length: 6,)
        ),

      ],
    );
  }
}
