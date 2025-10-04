import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../screens/auth_ui/signin_screen.dart';
import '../../controllers/google_signin_controller.dart';
import '../../utils/app_constants.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});
  final GoogleSigninController _googleSigninController = Get.put(
    GoogleSigninController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.appMainColour,
        title: Text(
          "Welcome to the app",
          style: TextStyle(
            color: AppConstants.appTextColour,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Lottie.asset('assets/images/splash.json'),
          SizedBox(height: 8),
          Text(
            "Happy Shopping",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: Get.height / 12),
          // Google Sign-In Button
          Container(
            width: Get.width / 1.2,
            height: Get.height / 13,
            decoration: BoxDecoration(
              color: AppConstants.appSecondaryColour,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton.icon(
              icon: Image.asset(
                'assets/images/google.png',
                height: 24,
                width: 24,
              ),
              onPressed: () {
                _googleSigninController.signInWithGoogle();
              },
              label: Text(
                "Sign in with Google",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: Get.height / 70),
          // Email Sign-In Button
          Container(
            width: Get.width / 1.2,
            height: Get.height / 13,
            decoration: BoxDecoration(
              color: AppConstants.appSecondaryColour,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton.icon(
              icon: Image.asset(
                'assets/images/email.png',
                height: 24,
                width: 24,
              ),
              onPressed: () {
                Get.to(() => SigninScreen());
              },
              label: Text(
                "Sign in with Email",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
