import 'package:azan/AppManager/Widgets/primary_button.dart';
import 'package:azan/AppManager/Widgets/primary_textfield.dart';
import 'package:azan/auth_controller.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  final AuthController controller;
  const SignUpView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final nameC = TextEditingController();
    final emailC = TextEditingController();
    final passwordC = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up'),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             PrimaryTextField(hintText: 'Enter Name',controller: nameC,),
            const SizedBox(height: 15,),
             PrimaryTextField(hintText: 'Enter Email',controller: emailC,),
            const SizedBox(height: 15,),
             PrimaryTextField(hintText: 'Enter Password',controller: passwordC,),
            const SizedBox(height: 25,),
            PrimaryButton(text: 'Sign Up', onPressed: () {
              controller.registerWithEmail(emailC.text,passwordC.text,nameC.text);
            },)
          ],
        ),
      ),
    );
  }
}
