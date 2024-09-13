import 'package:azan/AppManager/Constants/app_colors.dart';
import 'package:azan/AppManager/Constants/text_theme.dart';
import 'package:azan/AppManager/Widgets/primary_button.dart';
import 'package:azan/AppManager/Widgets/primary_textfield.dart';
import 'package:azan/AppManager/Widgets/radio_menu.dart';
import 'package:azan/Authentication/SignUp/sign_up_controller.dart';
import 'package:azan/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpView extends StatelessWidget {
  final AuthController authController;
  const SignUpView({super.key, required this.authController,});

  @override
  Widget build(BuildContext context) {
    SignUpController controller = Get.put(SignUpController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Setup your Account',
          style:
          context.text22!.copyWith(color: AppColor.white),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Create your username",
          style: context.text12
              ?.copyWith(color: AppColor.mustardColor),
        ),
        const SizedBox(
          height: 50,
        ),
        Text(
          'Name',
          style:
          context.text14?.copyWith(color: AppColor.white),
        ),
         CustomTextFormField(leadingWidget: const Icon(Icons.person_outline,color: Colors.grey,),
          controller: controller.nameC,
          hintText: 'Enter Name',),
        const SizedBox(height: 15,),
        Text('Gender',style: context.text14.copyWith(color: AppColor.white),),
        const SizedBox(height: 10,),
        Row(
          children: [
            Expanded(child: CustomRadioMenu(value: 1, groupValue: 1, onChanged: (value) {  }, text: 'Male',)),
            Expanded(child: CustomRadioMenu(value: 1, groupValue: 1, onChanged: (value) {  }, text: 'Female',)),
          ],
        ),
        const SizedBox(height: 50,),
        PrimaryButton(text: 'Continue', onPressed: (){
          authController.changePage('fiqh');
        },)
      ],
    );
  }
}
