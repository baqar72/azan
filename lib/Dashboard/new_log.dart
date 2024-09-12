import 'package:azan/AppManager/Constants/app_colors.dart';
import 'package:azan/AppManager/Constants/text_theme.dart';
import 'package:azan/AppManager/LocationService/location_service.dart';
import 'package:azan/AppManager/Widgets/primary_button.dart';
import 'package:azan/AppManager/Widgets/primary_textfield.dart';
import 'package:azan/AppManager/Widgets/searchable_dropdown.dart';
import 'package:azan/Authentication/LogIn/otp_view.dart';
import 'package:azan/Authentication/SignUp/sign_up_controller.dart';
import 'package:azan/Authentication/SignUp/sign_up_view.dart';
import 'package:azan/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginSignupScreen extends StatelessWidget {
  const LoginSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    TextEditingController phoneC = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading:authController.pageType!='login'? IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            authController.changePage('login');
            // Handle back button press
          },
        ):const SizedBox.shrink(),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background Image
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('asset/kaba.jpg'),
                  // Replace with your image path
                  fit: BoxFit.fill,
                  colorFilter:
                      ColorFilter.mode(Colors.black26, BlendMode.srcOver)),
            ),
          ),
          // Bottom Rounded Container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF121212), // Dark gray color
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    // Shadow with 10% opacity
                    offset: const Offset(0, -4),
                    // Offset the shadow upwards
                    blurRadius: 20,
                    // Blur radius
                    spreadRadius: 0, // Spread radius
                    // blendMode: BlendMode.multiply, // Multiply blending mode
                  ),
                ],
                image: DecorationImage(
                  image: const AssetImage('asset/net.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.1),
                    BlendMode.multiply,
                  ),
                ),
              ),
              child: GetBuilder<AuthController>(
                builder: (_) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
                    child: switch (authController.pageType) {
                      'login' => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              'Login/Signup',
                              style:
                                  context.text22!.copyWith(color: AppColor.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Enter your phone number to send the OTP",
                              style: context.text12
                                  ?.copyWith(color: AppColor.mustardColor),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Phone Number',
                              style:
                                  context.text14?.copyWith(color: AppColor.white),
                            ),
                            CustomTextFormField(
                              leadingWidget: Row(
                                children: [
                                  const Icon(
                                    Icons.phone,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  DropdownButton<String>(
                                    value: '+91',
                                    dropdownColor: Colors.black,
                                    items: <String>['+91', '+1', '+44', '+61']
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      // Handle change
                                      print(newValue);
                                    },
                                    underline: const SizedBox(),
                                  ),
                                ],
                              ),
                              controller: phoneC,
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            PrimaryButton(
                              text: 'Send OTP',
                              onPressed: () {
                                authController.phoneSignIn(phoneC.text);
                              },
                              width: double.infinity,
                            ),
                          ],
                        ),
                      'otp' => OtpPage(phoneNumber: phoneC.text, authController: authController,),
                      'signup'=> SignUpView(authController: authController,),
                      'location'=>GetBuilder<SignUpController>(
                        init: SignUpController(),
                        builder: (controller) {
                          return Column(
                            children: [
                              Image.asset('asset/location.png'),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Select Location",
                                style: context.text14
                                    ?.copyWith(color: AppColor.mustardColor),
                              ),
                              SearchableDropdown<dynamic>(items: controller.coordinateList, onItemSelected: (value) {  }, itemToString: (val) {
                                print(val);
                                return val.toString();
                              },hintText: 'Enter an Address',hintStyle: TextStyle(color: Colors.white70),
                              onChanged: (val){
                                print("oncahhe $val");
                                controller.getCoordinatesByAddress(val);
                              },),

                              PrimaryButton(text: 'location', onPressed: () {
                                Get.to(()=>LocationSearch());
                              },)
                            ],
                          );
                        }
                      ),
                      _ => const SizedBox.shrink()
                    },
                  );
                }
              ),
            ),
          ),
          // Image.asset('asset/net.png',colorBlendMode: BlendMode.multiply,)
        ],
      ),
    );
  }

// Widget _buildRadioOption(int value, String label) {
//   return Row(
//     children: [
//       Radio<int>(
//         value: value,
//         groupValue: _selectedTimes,
//         onChanged: (int? newValue) {
//           setState(() {
//             _selectedTimes = newValue!;
//           });
//         },
//         activeColor: Colors.orange,
//       ),
//       Text(
//         label,
//         style: TextStyle(
//           color: _selectedTimes == value ? Colors.orange : Colors.white,
//           fontWeight:
//               _selectedTimes == value ? FontWeight.bold : FontWeight.normal,
//         ),
//       ),
//     ],
//   );
// }
}
