import 'package:azan/AppManager/Constants/app_colors.dart';
import 'package:azan/AppManager/LocalStorage/ObjectBoxService/object_box_service.dart';
import 'package:azan/Authentication/LogIn/login.dart';
import 'package:azan/Dashboard/dashboard_view.dart';
import 'package:azan/Dashboard/new_log.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';
import 'firebase_options.dart';
late final ObjectBoxService objectBoxService;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBoxService = await ObjectBoxService.create();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: AppGlobals.navigatorKey,
      defaultTransition: Transition.leftToRight,
      title: 'Flutter Demo',
      theme: _buildReplyLightTheme(context),
      darkTheme: _buildReplyDarkTheme(context),
      getPages: AppPages.routes,
        initialRoute: AppPages.initialRoute,
    );
  }
}


class AppPages {
  // static UserToken? details=objectBoxService.getUserToken();
  static String initialRoute =objectBoxService.hasAnyUser()? '/dashboard':'/login';

  // String get getInitialRoute => userDataController.getUserData

  static final routes = [
    GetPage(
      name: '/login',
      page: () => const LoginSignupScreen(),
    ),
    GetPage(
      name: '/dashboard',
      page: () => const DashboardView(),
    ),
  ];
}

class AppGlobals {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

ThemeData _buildReplyLightTheme(BuildContext context) {
  final base = ThemeData.light();
  return base.copyWith(
    // bottomSheetTheme: BottomSheetThemeData(
    //   backgroundColor: ReplyColors.blue700,
    //   modalBackgroundColor: Colors.white.withOpacity(0.7),
    // ),
    // cardColor: ReplyColors.white50,
    // chipTheme: _buildChipTheme(
    //   ReplyColors.blue700,
    //   ReplyColors.lightChipBackground,
    //   Brightness.light,
    // ),
    colorScheme: const ColorScheme.light(
      primary: AppColor.mustardColor,
      // secondary: ReplyColors.orange500,
      // surface: ReplyColors.white50,
      // error: ReplyColors.red400,
      // onPrimary: ReplyColors.white50,
      // onSecondary: ReplyColors.black900,
      // onSurface: ReplyColors.black900,
      // onError: ReplyColors.black900,
    ),
    textTheme: _buildReplyLightTextTheme(base.textTheme),
    scaffoldBackgroundColor: Colors.white,
    // bottomAppBarTheme: const BottomAppBarTheme(
    //   color: ReplyColors.blue700,
    // ),
  );
}

ThemeData _buildReplyDarkTheme(BuildContext context) {
  final base = ThemeData.dark();
  return base.copyWith(
    // bottomSheetTheme: BottomSheetThemeData(
    //   backgroundColor: ReplyColors.darkDrawerBackground,
    //   modalBackgroundColor: Colors.black.withOpacity(0.7),
    // ),
    // cardColor: ReplyColors.darkCardBackground,
    // chipTheme: _buildChipTheme(
    //   ReplyColors.blue200,
    //   ReplyColors.darkChipBackground,
    //   Brightness.dark,
    // ),
    colorScheme: const ColorScheme.dark(
      primary: Colors.black,
      // secondary: ReplyColors.orange300,
      // surface: ReplyColors.black800,
      // error: ReplyColors.red200,
      // onPrimary: ReplyColors.black900,
      // onSecondary: ReplyColors.black900,
      // onBackground: ReplyColors.white50,
      // onSurface: ReplyColors.white50,
      // onError: ReplyColors.black900,
      // background: ReplyColors.black900,
    ),
    textTheme: _buildReplyDarkTextTheme(base.textTheme),
    scaffoldBackgroundColor: Colors.black87,
    // bottomAppBarTheme: const BottomAppBarTheme(
    //   color: ReplyColors.darkBottomAppBarBackground,
    // ),
  );
}

TextTheme _buildReplyLightTextTheme(TextTheme base) {
  return base.copyWith(
    headlineMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 22,
      letterSpacing: 0.4,
      height: 0.9,
      color: Colors.black87,
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      letterSpacing: 0.27,
      color: Colors.black87,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18,
      letterSpacing: 0.18,
      color: Colors.black87,
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      letterSpacing: -0.04,
      color: Colors.black87,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      letterSpacing: 0.2,
      color: Colors.black87,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 12,
      letterSpacing: -0.05,
      color: Colors.black87,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 10,
      letterSpacing: 0.2,
      color: Colors.black87,
    ),
  );
}

TextTheme _buildReplyDarkTextTheme(TextTheme base) {
  return base.copyWith(
    headlineMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 34,
      letterSpacing: 0.4,
      height: 0.9,
      color: Colors.white54,
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      letterSpacing: 0.27,
      color: Colors.white54,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      letterSpacing: 0.18,
      color: Colors.white54,
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      letterSpacing: -0.04,
      color: Colors.white54,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 18,
      letterSpacing: 0.2,
      color: Colors.white54,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      letterSpacing: -0.05,
      color: Colors.white54,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 12,
      letterSpacing: 0.2,
      color: Colors.white54,
    ),
  );
}