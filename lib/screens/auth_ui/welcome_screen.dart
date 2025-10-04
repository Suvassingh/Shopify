import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
<<<<<<< HEAD
import '../../screens/auth_ui/signin_screen.dart';
import '../../controllers/google_signin_controller.dart';
import '../../utils/app_constants.dart';

class WelcomeScreen extends StatelessWidget {
   WelcomeScreen({super.key});
  final GoogleSigninController _googleSigninController = Get.put(GoogleSigninController());
=======
import '../../utils/app_constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
>>>>>>> 1e4db88fdb7272423e90a3ffcad881be9a8e1e67

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
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(child: Lottie.asset('assets/images/splash.json')),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Text(
                "Happy Shopping",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: Get.height / 12),
            Material(
              child: Container(
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
<<<<<<< HEAD
                  onPressed: () {
                    _googleSigninController.signInWithGoogle();
                  },
=======
                  onPressed: () {},
>>>>>>> 1e4db88fdb7272423e90a3ffcad881be9a8e1e67
                  label: Text(
                    "Sign in with google",
                    style: TextStyle(
                      color: AppConstants.appTextColour,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.height / 70),
            Material(
              child: Container(
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
<<<<<<< HEAD
                  onPressed: () {
                    Get.to(()=>SigninScreen());
                  },
=======
                  onPressed: () {},
>>>>>>> 1e4db88fdb7272423e90a3ffcad881be9a8e1e67
                  label: Text(
                    "Sign in with email",
                    style: TextStyle(
                      color: AppConstants.appTextColour,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
