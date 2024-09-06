import 'package:azan/AppManager/LocalStorage/ObjectBoxService/object_box_service.dart';
import 'package:azan/Authentication/LogIn/login.dart';
import 'package:azan/Dashboard/dashboard_view.dart';
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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
      page: () => const PhoneSignInPage(),
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