import 'package:azan/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpPage extends StatelessWidget {
  final String phoneNumber;

  const OtpPage({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final otpController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter OTP"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "We have sent an OTP to $phoneNumber",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: otpController,
              decoration: InputDecoration(
                labelText: "Enter OTP",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Obx(() => authController.isLoading.value
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () {
                authController.verifyOTP(otpController.text);
              },
              child: Text("Verify OTP"),
            )),
            SizedBox(height: 20),
            Obx(() => Text(
              authController.authStatus.value,
              style: TextStyle(color: Colors.red),
            )),
          ],
        ),
      ),
    );
  }
}
