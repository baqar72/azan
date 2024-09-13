import 'dart:async';

import 'package:azan/AppManager/LocalStorage/Entity/user_model.dart' as user;
import 'package:azan/Authentication/LogIn/otp_view.dart';
import 'package:azan/DashBoard/dashboardView.dart';
import 'package:azan/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var verificationId = ''.obs;
  var isLoading = false.obs;
  var authStatus = ''.obs;
  String pageType = 'login';
  void changePage(String page){
    pageType = page;
    update();
  }


  User? get currentUser => _auth.currentUser;

  // Method to initiate phone number authentication
  void phoneSignIn(String phoneNumber) async {
    isLoading(true);
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91$phoneNumber",
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        authStatus('Phone number automatically verified and user signed in');
        isLoading(false);

        // Store user data in Firestore after automatic verification
        if (_auth.currentUser != null) {
          storeUserData(name: "User Name", email: "user@example.com", phone: phoneNumber);
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        authStatus('Failed to verify phone number: ${e.message}');
        isLoading(false);
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId.value = verificationId;
        authStatus('Verification code sent to $phoneNumber');
        isLoading(false);
        changePage('otp');
        // Navigate to the OTP Page after code is sent
        // Get.to(() => OtpPage(phoneNumber: phoneNumber));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId.value = verificationId;
        isLoading(false);
      },
    );
  }


  // Method to verify OTP
  Future<void> verifyOTP(String smsCode) async {
    try {
      isLoading(true);
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);
      authStatus('Phone number verified and user signed in');

      // After OTP verification, store user info in Firestore
      if (_auth.currentUser != null) {
        // storeUserData(name: "User Name", email: "user@example.com", phone: _auth.currentUser!.phoneNumber);
      }
      changePage('signup');
      // Navigate to the desired page after successful sign-in
      //  Get.offAll(() => const DashboardView()); // Replace HomePage with your target page
    } catch (e) {
      authStatus('Failed to sign in: $e');
    } finally {
      isLoading(false);
    }
  }

  // Sign in with Email and Password
  Future<void> signInWithEmail(String email, String password) async {
    try {
      isLoading(true);
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        authStatus('Signed in with email successfully');
         Get.offAll(() => DashBoardView()); // Replace HomePage with your target page
      }
    } on FirebaseAuthException catch (e) {
      authStatus('Failed to sign in with email: ${e.message}');
    } finally {
      isLoading(false);
    }
  }

  // Register with Email and Password
  Future<void> registerWithEmail(String email, String password, String name) async {
    try {
      isLoading(true);
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Store user data in Firestore
        final userData=user.User(uid: _auth.currentUser!.uid, name: name, email: email, phone: '');
       await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
          'uid': _auth.currentUser!.uid,
          'name': name,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });

        await objectBoxService.saveUser(userData);

        authStatus('Registered with email successfully');
         Get.offAll(() => const DashBoardView()); // Replace HomePage with your target page
      }
    } on FirebaseAuthException catch (e) {
      authStatus('Failed to register with email: ${e.message}');
    } finally {
      isLoading(false);
    }
  }


  // Method to store user data in Firestore
  Future<void> storeUserData({required String name, required String email, required String? phone}) async {
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
        'uid': _auth.currentUser!.uid,
        'name': name,
        'email': email,
        'phone': phone,
        'createdAt': FieldValue.serverTimestamp(),
      });
      authStatus('User data stored successfully');
    } catch (e) {
      authStatus('Failed to store user data: $e');
    }
  }

  void deleteUser()async{
    await _auth.currentUser?.delete();
  }

  // Method to log out the user
  Future<void> logout() async {
    try {
      // Sign out from Firebase
      await _auth.signOut();

      // Clear user data from local storage
      objectBoxService.clearAllUsers();
      print("successfully logged out");

      // Navigate to the login page
      Get.offAllNamed('/login');

      // Optional: You can also reset the application state or notify users
      // Example: show a message or reset other controllers
    } catch (e) {
      // Handle any errors that occur during logout
      print('Logout failed: $e');
    }
  }

  // Method to delete user data from Firestore
  Future<void> deleteUserData() async {
    try {
      // Get the current user
      final user = _auth.currentUser;
      if (user != null) {
        // Define the document reference
        final userDoc = _firestore.collection('users').doc(user.uid);

        // Delete the document
        await userDoc.delete();

        print('User data deleted successfully');
      } else {
        print('No user is currently signed in');
      }
    } catch (e) {
      // Handle any errors that occur during deletion
      print('Failed to delete user data: $e');
    }
  }
///////////////new
  RxDouble containerHeight = 400.0.obs;
  RxInt step = 0.obs;
  dynamicHeightAllocation(){
    step.value = step.value +1;
    print(" STEP VALUE ${step.value}");
    if(step.value == 1){
      containerHeight.value = 350;
    }
    else if(step.value==2){
      containerHeight.value=  400;
    }
    else if(step.value==3){
      containerHeight.value=250;
    }
    else if(step.value==4){
      containerHeight.value=300;
    }
    update();
  }
  RxBool isOtpFilled = false.obs;
  RxBool isOtpVerified = false.obs;
  RxBool showThirdContainer = false.obs;
  RxBool showFourthContainer = false.obs;
  var selectedGender = "Male".obs;
  void updateGender(String gender){
    selectedGender.value=gender;
  }
  RxBool showSecondContainer = false.obs;
  void toggleSecondContainer() {
    showSecondContainer.value = !showSecondContainer.value;
  }
  void toggleThirdContainer() {
    showThirdContainer.value = !showThirdContainer.value;
  }
  void toggleFourthContainer() {
    showFourthContainer.value = !showFourthContainer.value;
  }
  RxInt secondsLeft = 60.obs;
  late Timer _timer;
  void verifyOtp(String code) {
    if (code.length == 6) {
      isOtpVerified.value = true;
      showThirdContainer.value = true;
    }

}
  final Rx<TextEditingController> phoneController = TextEditingController().obs;
}
