import 'package:azan/AppManager/Constants/app_colors.dart';
import 'package:azan/AppManager/Constants/text_theme.dart';
import 'package:azan/AppManager/Widgets/primary_button.dart';
import 'package:azan/AppManager/Widgets/radio_menu.dart';
import 'package:azan/DashBoard/dashboardView.dart';
import 'package:azan/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FiqhView extends StatelessWidget {
  final AuthController authController;
  const FiqhView({super.key, required this.authController});

  @override
  Widget build(BuildContext context) {
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
        "Select your School of Thought",
        style: context.text12
            ?.copyWith(color: AppColor.mustardColor),
      ),
      const SizedBox(
        height: 50,
      ),
        Text('Fiqh',style: context.text14.copyWith(color: AppColor.white),),
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(child: CustomRadioMenu(value: 1, groupValue: 1, onChanged: (value) {  }, text: 'Shia',)),
            Expanded(child: CustomRadioMenu(value: 1, groupValue: 1, onChanged: (value) {  }, text: 'Sunni',)),
          ],
        ),
        SizedBox(height: 10,),
        Text('Times of Prayer',style: context.text14.copyWith(color: AppColor.white),),
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(child: CustomRadioMenu(value: 1, groupValue: 1, onChanged: (value) {  }, text: '3 Times',)),
            Expanded(child: CustomRadioMenu(value: 1, groupValue: 1, onChanged: (value) {  }, text: '5 Times',)),
          ],
        ),
      const SizedBox(height: 50,),
      PrimaryButton(text: 'Submit', onPressed: (){
        Get.to(()=>DashBoardView());
        // authController.changePage('location');
      },)
      ],
    );
  }
}
