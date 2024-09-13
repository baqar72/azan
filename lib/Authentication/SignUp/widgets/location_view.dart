import 'package:azan/AppManager/Constants/app_colors.dart';
import 'package:azan/AppManager/Constants/text_theme.dart';
import 'package:azan/AppManager/Widgets/primary_button.dart';
import 'package:azan/AppManager/Widgets/searchable_dropdown.dart';
import 'package:azan/Authentication/SignUp/sign_up_controller.dart';
import 'package:azan/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationView extends StatelessWidget {
  final AuthController authController;
  const LocationView({super.key, required this.authController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
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
              SizedBox(
                height: 40,
              ),
              SearchableDropdown<dynamic>(
                onItemSelected: (value) {
                  print("selected $value");
                },
                itemToString: (val) {
                  print('val $val');
                  return val['properties']['formatted'] ??
                      'Unknown';
                },
                hintText: 'Enter an Address',
                hintStyle: const TextStyle(color: Colors.white70),
                onChanged: (query) async {
                  final List<dynamic> fetchedItems =
                  await controller.getCoordinatesByAddress(
                      query); // API call to fetch data
                  return fetchedItems;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              Text('or',style: context.text16.copyWith(color: Colors.white70),),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: double.infinity,
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: RadialGradient(
                    colors: [
                      Color(0xFFFFFFFF).withOpacity(0.1),
                      Color(0xFFFFFFFF).withOpacity(0.0224),
                      Color(0xFFFFFFFF).withOpacity(0.0),
                    ],
                    radius: 8.0,
                  ),
                  border: Border.all(
                    color: Colors.white70,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on,size: 18,color: Colors.white70,),
                    const SizedBox(width: 3,),
                    Expanded(child: Text('Get Current Location',style: context.text14?.copyWith(color: Colors.white),)),
                    const Icon(Icons.arrow_forward_ios,size: 18,color: Colors.white70,),
                  ],
                ),
              ),

              const SizedBox(height: 30,),
              PrimaryButton(
                text: 'Next',
                onPressed: () {
                  authController.changePage('fiqh');
                  // Get.to(() => LocationSearch());
                },
              )
            ],
          );
        });
  }
}
