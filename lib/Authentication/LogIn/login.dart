
import 'package:azan/AppManager/Widgets/primary_button.dart';
import 'package:azan/AppManager/Widgets/primary_textfield.dart';
import 'package:azan/Authentication/SignUp/sign_up_view.dart';
import 'package:azan/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneSignInPage extends StatelessWidget {

  const PhoneSignInPage({super.key});


  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Sign In"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryTextField(hintText: 'Enter Email',),
            SizedBox(height: 15,),
            PrimaryTextField(hintText: 'Enter Password',),
            const SizedBox(height: 25),
            PrimaryButton(text: 'Login', onPressed: () {
              authController.signInWithEmail('faiznaqvi68@gmail.com',"demo123",);
            },),
            // Obx(() => authController.isLoading.value
            //     ? const CircularProgressIndicator()
            //     : ElevatedButton(
            //   onPressed: () {
            //     authController.phoneSignIn(phoneController.text);
            //   },
            //   child: Text("Send OTP"),
            // )),
            SizedBox(height: 20),
            Obx(() => Text(
              authController.authStatus.value,
              style: TextStyle(color: Colors.red),
            )),
            SizedBox(height: 10,),
            Text('or',textAlign: TextAlign.center,),
            SizedBox(height: 10,),
            TextButton(onPressed: (){
              Get.to(()=> SignUpView(controller: authController,));
            }, child: const Text("Sign in with Email and Password")),
            // ElevatedButton(onPressed: (){
            //   authController.signInWithEmail('faiznaqvi68@gmail.com',"password",);
            // }, child: Text('login')),
            // ElevatedButton(onPressed: (){
            //   authController.deleteUser();
            // }, child: Text('delete')),

          ],
        ),
      ),
    );
  }
}
