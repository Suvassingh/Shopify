import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify/screens/auth_ui/signup_screen.dart';
import '../screens/auth_ui/signin_screen.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SignupScreen(),
    );
  }
}

