import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/features/authentication/presentation/screens/Login.dart';
import 'package:meal_app/features/home/presentation/screens/home_screen.dart';
import 'package:meal_app/features/splash/presentation/screens/splash_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // Specify the design size for responsiveness
      builder: (context, child) {
        return MaterialApp(
          // Generate routes dynamically
          debugShowCheckedModeBanner: false, // Disable the debug banner
          home: Splash_view(),

        );
      },
    );
  }
}