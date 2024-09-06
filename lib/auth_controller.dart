import 'package:azan/AppManager/LocalStorage/Entity/user_model.dart' as user;
import 'package:azan/Authentication/LogIn/otp_view.dart';
import 'package:azan/Dashboard/dashboard_view.dart';
import 'package:azan/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var verificationId = ''.obs;
  var isLoading = false.obs;
  var authStatus = ''.obs;

  User? get currentUser => _auth.currentUser;

  // Method to initiate phone number authentication
  void phoneSignIn(String phoneNumber) async {
    isLoading(true);
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
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

        // Navigate to the OTP Page after code is sent
        Get.to(() => OtpPage(phoneNumber: phoneNumber));
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
        storeUserData(name: "User Name", email: "user@example.com", phone: _auth.currentUser!.phoneNumber);
      }

      // Navigate to the desired page after successful sign-in
       Get.offAll(() => const DashboardView()); // Replace HomePage with your target page
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
         Get.offAll(() => DashboardView()); // Replace HomePage with your target page
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
         Get.offAll(() => const DashboardView()); // Replace HomePage with your target page
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
}
