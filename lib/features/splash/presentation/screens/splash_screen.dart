import 'package:flutter/material.dart';
import 'package:meal_app/features/splash/presentation/widgets/Splash_body.dart';
class Splash_view extends StatelessWidget {
  const Splash_view({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:SplashBody(),

    );
  }
}