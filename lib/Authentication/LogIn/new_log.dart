import 'package:azan/AppManager/Constants/app_colors.dart';
import 'package:azan/AppManager/Constants/text_theme.dart';
import 'package:azan/AppManager/LocationService/location_service.dart';
import 'package:azan/AppManager/Widgets/primary_button.dart';
import 'package:azan/AppManager/Widgets/primary_textfield.dart';
import 'package:azan/AppManager/Widgets/searchable_dropdown.dart';
import 'package:azan/Authentication/LogIn/otp_view.dart';
import 'package:azan/Authentication/SignUp/sign_up_controller.dart';
import 'package:azan/Authentication/SignUp/sign_up_view.dart';
import 'package:azan/Authentication/SignUp/widgets/fiqh_view.dart';
import 'package:azan/Authentication/SignUp/widgets/location_view.dart';
import 'package:azan/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

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
        leading: authController.pageType != 'login'
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  authController.changePage('login');
                  // Handle back button press
                },
              )
            : const SizedBox.shrink(),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background image
          Container(
            height: 600,
            decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: 10,
                image: AssetImage("asset/kaba.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Obx(() {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                height: authController.containerHeight.value,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    opacity: 9,
                    image: AssetImage("asset/net.png"),
                  ),
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: authController.step.value == 0?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50),
                        Text("Login/Signup",
                            // style: MyTextTheme.largeWCB
                        ),
                        Text("Enter your phone number to send the OTP",
                            // style: MyTextTheme.mustardS
                        ),
                        SizedBox(height: 30),
                        IntlPhoneField(
                          cursorColor: Colors.grey,
                          controller: authController.phoneController.value,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.local_phone_outlined,
                              color: Colors.white,
                            ),
                            prefix: SizedBox(width: 10),
                            hintText: "Enter  your phone number",
                           hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            counterText: "",
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          initialCountryCode: 'IN',
                          dropdownIconPosition: IconPosition.trailing,
                          dropdownTextStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          showCountryFlag: false,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          onChanged: (phone) {
                            print(phone.completeNumber);
                          },
                        ),
                        SizedBox(height: 20),
                        PrimaryButton(
                          // height: 60,
                          // borderRadius: 10,
                          // elevation: 2,
                          text: "Send OTP",
                          // color: controller.isPhoneNumberValid.value
                          //     ? Colors.yellow
                          //     : AppColor.greyColor,
                          onPressed: () async{
                             authController.dynamicHeightAllocation();
                             authController.phoneSignIn(authController.phoneController.value.text);
                            print("Send OTP");
                          },
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            authController.toggleSecondContainer();
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColor.packageGray),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("asset/googleLogo.png"),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Log in with Google",
                                      // style: MyTextTheme.smallWCB
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ):
                    authController.step.value == 1?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        if (!authController.isOtpVerified.value) ...[
                          Text("Verifying Your Account",
                              // style: MyTextTheme.largeWCB
                          ),
                          Text("Please enter the 6 digit verification code sent to",
                              // style: MyTextTheme.mustardS
                          ),
                          SizedBox(height: 40),
                          OtpTextField(
                            autoFocus: false,
                            focusedBorderColor: Colors.white,
                            numberOfFields: 6,
                            borderColor: const Color(0xFF512DA8),
                            borderWidth: 1.0,
                            showFieldAsBox: true,
                            fieldWidth: 45,
                            borderRadius: BorderRadius.circular(10),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            showCursor: false,
                            fieldHeight: 45,
                            textStyle: TextStyle(color: Colors.white),
                            onCodeChanged: ( String code) {
                              authController.isOtpFilled.value = code.length == 6;
                              if (authController.isOtpFilled.value) {
                                authController.verifyOtp(code);
                              }
                            },
                            onSubmit: (String verificationCode){
                              authController.dynamicHeightAllocation();

                            }, // end onSubmit

                          ),
                          const SizedBox(height: 20),
                          Obx(() {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (authController.isOtpFilled.value) ...[
                                  Text("Verifying Your OTP...",
                                      // style: MyTextTheme.largeWCB
                                  ),
                                  SizedBox(height: 10),
                                ],
                                Text("Didn't receive an OTP?",
                                    // style: MyTextTheme.smallWCN
                                ),
                                SizedBox(height: 10),
                                Obx(() {
                                  final seconds = authController.secondsLeft.value;
                                  final minutes = seconds ~/ 60;
                                  final remainingSeconds = seconds % 60;
                                  final formattedTime = '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';

                                  return RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(text: "Resend OTP ",
                                            // style: MyTextTheme.mediumBCb
                                        ),
                                        TextSpan(text: "in ",
                                            // style: MyTextTheme.smallWCN
                                        ),
                                        WidgetSpan(
                                          child: Icon(
                                            Icons.timer_outlined,
                                            size: 15,
                                            color: AppColor.circleIndicator,
                                          ),
                                        ),
                                        TextSpan(text: " $formattedTime",
                                            // style: MyTextTheme.mustardSN
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            );
                          }
                          ),
                        ] else ...[
                          Center(
                            child: Text("OTP Verifying Successfully",
                                // style: MyTextTheme.largeWCB
                            ),
                          ),
                        ],
                      ],
                    ):
                    authController.step.value == 2?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30,),
                        Text("Setup your Account",
                            // style: MyTextTheme.largeWCB
                        ),
                        Text("Enter your name",
                            // style: MyTextTheme.mustardS
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("First Name",
                            // style: MyTextTheme.mediumWCN,
                          ),
                        ),
                        TextField(
                          cursorColor: AppColor.circleIndicator,
                          decoration: InputDecoration(
                            hintText: "Enter your first name",
                            // hintStyle: MyTextTheme.mediumCustomGCN,
                            prefixIcon: Image.asset("assets/profile.png"),
                            fillColor: Colors.white.withOpacity(0.1),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Last Name",
                            // style: MyTextTheme.mediumWCN,
                          ),
                        ),
                        TextField(
                          cursorColor: AppColor.circleIndicator,
                          decoration: InputDecoration(
                            hintText: "Enter your first name",
                            // hintStyle: MyTextTheme.mediumCustomGCN,
                            prefixIcon: Image.asset("assets/profile.png"),
                            fillColor: Colors.white.withOpacity(0.1),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 30,),
                        PrimaryButton(
                          height: 60,
                          borderRadius: 10,
                          // elevation: 2,
                          text: "Next",
                          // color: controller.isPhoneNumberValid.value
                          //     ? Colors.yellow
                          //     : AppColor.greyColor,
                          onPressed: () {
                            authController.dynamicHeightAllocation();
                            print("aaaaaaaaaaaaaaaaa");
                          },
                        ),
                        SizedBox(height: 10,)
                      ],
                    ):
                    authController.step.value == 3?
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30,),
                          Text("Setup your Account",
                              // style: MyTextTheme.largeWCB
                          ),
                          Text("Select your gender",
                              // style: MyTextTheme.mustardS
                          ),
                          SizedBox(height: 20,),
                          Row(
                              children: [
                                Obx(()=>
                                    Radio<String>(
                                      value:"Male",
                                      activeColor: AppColor.circleIndicator,
                                      groupValue: authController.selectedGender.value,
                                      onChanged: (String? value){
                                        authController.updateGender(value!);
                                      },
                                    )),
                                Text("Male",
                                  // style: MyTextTheme.mediumWCN,
                                ),
                                SizedBox(width: 100,),
                                Obx(()=>
                                    Radio(
                                      value: "Female",
                                      activeColor: AppColor.circleIndicator,
                                      groupValue:  authController.selectedGender.value,
                                      onChanged: (String? value){
                                        authController.updateGender(value!);
                                      },
                                    )),
                                InkWell(
                                    onTap:(){
                                      // Get.toNamed(AppRoutes.dashboardRoute);
                                    },
                                    child: Text("Female",
                                      // style: MyTextTheme.mediumWCN,
                                    ))
                              ]
                          )
                        ]

                    ):

                    Column(
                      children: [

                      ],
                    )
                ),

              );
            }),
          ),


          // First animated container sliding up from the bottom
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Obx(() {
//               return AnimatedContainer(
//                 duration: const Duration(seconds: 1),
//                 curve: Curves.easeInOut,
//                 height: controller.isBottomSheetExpanded.value ? 400 : 0,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     opacity: 9,
//                     image: AssetImage("assets/net.png"),
//                   ),
//                   color: Colors.black,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(9.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 50),
//                       Text("Login/Signup", style: MyTextTheme.largeWCB),
//                       Text("Enter your phone number to send the OTP", style: MyTextTheme.mustardS),
//                       SizedBox(height: 30),
//                       IntlPhoneField(
//                         cursorColor: Colors.grey,
//                         controller: controller.phoneController.value,
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(
//                             Icons.local_phone_outlined,
//                             color: Colors.white,
//                           ),
//                           prefix: SizedBox(width: 10),
//                           hintText: "Enter  your phone number",
//                           hintStyle: MyTextTheme.mediumCustomGCN,
//                           filled: true,
//                           fillColor: Colors.grey.withOpacity(0.1),
//                           counterText: "",
//                           border: const OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                             borderSide: BorderSide(color: Colors.white),
//                           ),
//                           enabledBorder: const OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                             borderSide: BorderSide(color: Colors.white),
//                           ),
//                           focusedBorder: const OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                             borderSide: BorderSide(color: Colors.white),
//                           ),
//                         ),
//                         initialCountryCode: 'IN',
//                         dropdownIconPosition: IconPosition.trailing,
//                         dropdownTextStyle: const TextStyle(
//                           color: Colors.grey,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         showCountryFlag: false,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                         ),
//                         onChanged: (phone) {
//                           print(phone.completeNumber);
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       Obx(() {
//                         return MyButton(
//                           height: 60,
//                           borderRadius: 10,
//                           elevation: 2,
//                           title: "Send OTP",
//                           color: controller.isPhoneNumberValid.value
//                               ? Colors.yellow
//                               : AppColor.greyColor,
//                           onPressed: () {
//                             print("Send OTP");
//                           },
//                         );
//                       }),
//                       SizedBox(height: 20),
//                       InkWell(
//                         onTap: () {
//                           controller.toggleSecondContainer();
//                         },
//                         child: Container(
//                           height: 50,
//                           decoration: BoxDecoration(
//                             color: Colors.grey.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(color: AppColor.packageGray),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Image.asset("assets/googleLogo.png"),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text("Log in with Google", style: MyTextTheme.smallWCB),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//           ),
//           // Second animated container
//           Obx(() {
//             return Align(
//               alignment: Alignment.bottomCenter,
//               child: AnimatedContainer(
//                 duration: const Duration(seconds: 1),
//                 curve: Curves.easeInOut,
//                 height: controller.showSecondContainer.value ? 400 : 0,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   image: DecorationImage(image: AssetImage('assets/blacknet.png')),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(18.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 50),
//                       if (!controller.isOtpVerified.value) ...[
//                         Text("Verifying Your Account", style: MyTextTheme.largeWCB),
//                         Text("Please enter the 6 digit verification code sent to", style: MyTextTheme.mustardS),
//                         SizedBox(height: 40),
//                         OtpTextField(
//                           autoFocus: false,
//
//                           focusedBorderColor: Colors.white,
//                           numberOfFields: 6,
//                           borderColor: const Color(0xFF512DA8),
//                           borderWidth: 1.0,
//                           showFieldAsBox: true,
//                           fieldWidth: 45,
//                           borderRadius: BorderRadius.circular(10),
//                           filled: true,
//                           fillColor: Colors.grey.withOpacity(0.1),
//                           showCursor: false,
//                           fieldHeight: 45,
//                           textStyle: TextStyle(color: Colors.white),
//                           onCodeChanged: ( String code) {
//                             controller.isOtpFilled.value = code.length == 6;
//                             if (controller.isOtpFilled.value) {
//                               controller.verifyOtp(code);
//                             }
//                           },
//                           onSubmit: (String verificationCode){
//                             controller.toggleThirdContainer();
//
//                           }, // end onSubmit
//
//                         ),
//
//                         const SizedBox(height: 20),
//                         Obx(() {
//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               if (controller.isOtpFilled.value) ...[
//                                 Text("Verifying Your OTP...", style: MyTextTheme.largeWCB),
//                                 SizedBox(height: 10),
//                               ],
//                               Text("Didn't receive an OTP?", style: MyTextTheme.smallWCN),
//                               SizedBox(height: 10),
//                               Obx(() {
//                                 final seconds = controller.secondsLeft.value;
//                                 final minutes = seconds ~/ 60;
//                                 final remainingSeconds = seconds % 60;
//                                 final formattedTime = '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
//
//                                 return RichText(
//                                   text: TextSpan(
//                                     children: [
//                                       TextSpan(text: "Resend OTP ", style: MyTextTheme.mediumBCb),
//                                       TextSpan(text: "in ", style: MyTextTheme.smallWCN),
//                                       WidgetSpan(
//                                         child: Icon(
//                                           Icons.timer_outlined,
//                                           size: 15,
//                                           color: AppColor.circleIndicator,
//                                         ),
//                                       ),
//                                       TextSpan(text: " $formattedTime", style: MyTextTheme.mustardSN),
//                                     ],
//                                   ),
//                                 );
//                               }),
//                             ],
//                           );
//                         }
//                         ),
//                       ] else ...[
//                         Center(
//                           child: Text("OTP Verifying Successfully", style: MyTextTheme.largeWCB),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }),
// // Third animated container
//           Obx(() {
//             return Align(
//               alignment: Alignment.bottomCenter,
//               child: AnimatedContainer(
//                 duration: const Duration(seconds: 1),
//                 curve: Curves.easeInOut,
//                 height: controller.showThirdContainer.value ? 400 : 0,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage("assets/blacknet.png")),
//                   color: Colors.black,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                       const SizedBox(height: 30),
//                   Text("Setup your Account", style: MyTextTheme.largeWCB),
//                   Text("Enter your name", style: MyTextTheme.mustardS),
//                         SizedBox(height: 20,),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text("First Name",style: MyTextTheme.mediumWCN,),
//                         ),
//                         TextField(
//                           decoration: InputDecoration(
//                             hintText: "Enter your first name",
//                             hintStyle: MyTextTheme.mediumCustomGCN,
//                             prefixIcon: Image.asset("assets/profile.png"),
//                             fillColor: Colors.white.withOpacity(0.1),
//                             filled: true,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(
//                                 color: Colors.white,
//                               ),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(
//                                 color: Colors.white,
//                                 width: 2,
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(
//                                 color: Colors.white,
//                                 width: 2,
//                               ),
//                             ),
//                           ),
//                           style: const TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text("Last Name",style: MyTextTheme.mediumWCN,),
//                         ),
//                         TextField(
//                           decoration: InputDecoration(
//                             prefixIcon: Image.asset("assets/profile.png"),
//                             hintText: "Enter your last name",
//                             hintStyle: MyTextTheme.mediumCustomGCN,
//                             fillColor: Colors.white.withOpacity(0.1),
//                             filled: true,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(
//                                 color: Colors.white,
//                               ),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(
//                                 color: Colors.white,
//                                 width: 2,
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(
//                                 color: Colors.white,
//                                 width: 2,
//                               ),
//                             ),
//                           ),
//                           style: const TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                     SizedBox(height: 20,),
//                     MyButton(
//                       height: 60,
//                       borderRadius: 10,
//                       elevation: 2,
//                       title: "Send OTP",
//                       color: controller.isPhoneNumberValid.value
//                           ? Colors.yellow
//                           : AppColor.greyColor,
//                       onPressed: () {
//                         controller.toggleFourthContainer();
//                         print("Send OTP");
//                       },
//                     ),
//                         SizedBox(height: 10,)
//
//
//
//                       ]
//                                 ),
//                 ),
//             ));
//           }),
//           Obx(() {
//             return Align(
//                 alignment: Alignment.bottomCenter,
//                 child: AnimatedContainer(
//                   duration: const Duration(seconds: 1),
//                   curve: Curves.easeInOut,
//                   height: controller.showFourthContainer.value ? 400 : 0,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage("assets/blacknet.png")),
//                     color: Colors.black,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox(height: 30),
//                           Text("Setup your Account", style: MyTextTheme.largeWCB),
//                           Text("Select your gender", style: MyTextTheme.mustardS),
//                           SizedBox(height: 20,),
//
//
//
//
//
//                         ]
//                     ),
//                   ),
//                 ));
//           }),


        ],
      ),
      // Stack(
      //   children: [
      //     // Background Image
      //     Container(
      //       height: MediaQuery.of(context).size.height * 0.5,
      //       decoration: const BoxDecoration(
      //         image: DecorationImage(
      //             image: AssetImage('asset/kaba.jpg'),
      //             // Replace with your image path
      //             fit: BoxFit.fill,
      //             colorFilter:
      //                 ColorFilter.mode(Colors.black26, BlendMode.srcOver)),
      //       ),
      //     ),
      //     // Bottom Rounded Container
      //     Align(
      //       alignment: Alignment.bottomCenter,
      //       child: Obx((){
      //         return AnimatedContainer(
      //             duration: const Duration(milliseconds: 800),
      //             curve: Curves.easeInOut,
      //             height: authController.containerHeight.value,
      //             width: MediaQuery.of(context).size.width,
      //             decoration: const BoxDecoration(
      //               image: DecorationImage(
      //                 opacity: 9,
      //                 image: AssetImage("assets/net.png"),
      //               ),
      //               color: Colors.black,
      //               borderRadius: BorderRadius.only(
      //                 topLeft: Radius.circular(20),
      //                 topRight: Radius.circular(20),
      //               ),
      //             ),
      //             child: SingleChildScrollView(
      //               child: GetBuilder<AuthController>(builder: (_) {
      //                 return Padding(
      //                   padding: const EdgeInsets.symmetric(
      //                       horizontal: 20.0, vertical: 50),
      //                   child: switch (authController.pageType) {
      //                     'login' => Column(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         children: [
      //                           // Title
      //                           Text(
      //                             'Login/Signup',
      //                             style: context.text22!
      //                                 .copyWith(color: AppColor.white),
      //                           ),
      //                           const SizedBox(
      //                             height: 10,
      //                           ),
      //                           Text(
      //                             "Enter your phone number to send the OTP",
      //                             style: context.text12
      //                                 ?.copyWith(color: AppColor.mustardColor),
      //                           ),
      //                           const SizedBox(
      //                             height: 30,
      //                           ),
      //                           Text(
      //                             'Phone Number',
      //                             style: context.text14
      //                                 ?.copyWith(color: AppColor.white),
      //                           ),
      //                           CustomTextFormField(
      //                             keyboardType: TextInputType.number,
      //                             leadingWidget: Row(
      //                               children: [
      //                                 const Icon(
      //                                   Icons.phone,
      //                                   color: Colors.grey,
      //                                 ),
      //                                 const SizedBox(
      //                                   width: 5,
      //                                 ),
      //                                 DropdownButton<String>(
      //                                   value: '+91',
      //                                   dropdownColor: Colors.black,
      //                                   items: <String>['+91', '+1', '+44', '+61']
      //                                       .map((String value) {
      //                                     return DropdownMenuItem<String>(
      //                                       value: value,
      //                                       child: Text(
      //                                         value,
      //                                         style: TextStyle(color: Colors.white),
      //                                       ),
      //                                     );
      //                                   }).toList(),
      //                                   onChanged: (String? newValue) {
      //                                     // Handle change
      //                                     print(newValue);
      //                                   },
      //                                   underline: const SizedBox(),
      //                                 ),
      //                               ],
      //                             ),
      //                             controller: phoneC,
      //                           ),
      //                           const SizedBox(
      //                             height: 50,
      //                           ),
      //                           PrimaryButton(
      //                             text: 'Send OTP',
      //                             onPressed: () {
      //                               authController.phoneSignIn(phoneC.text);
      //                             },
      //                             width: double.infinity,
      //                           ),
      //                         ],
      //                       ),
      //                     'otp' => OtpPage(
      //                         phoneNumber: phoneC.text,
      //                         authController: authController,
      //                       ),
      //                     'signup' => SignUpView(
      //                         authController: authController,
      //                       ),
      //                     'location' =>  LocationView(authController: authController,),
      //                     'fiqh' =>  FiqhView(authController: authController,),
      //                     _ => const SizedBox.shrink()
      //                   },
      //                 );
      //               }),
      //             ),
      //           );
      //         }
      //       ),
      //     ),
      //     // Image.asset('asset/net.png',colorBlendMode: BlendMode.multiply,)
      //   ],
      // ),
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
