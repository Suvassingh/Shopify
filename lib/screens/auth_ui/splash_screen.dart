import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:shopify/controllers/get_userdata_controller.dart';
import 'package:shopify/screens/admin_pannel/admin_main_screen.dart';
import 'package:shopify/screens/user_pannel/main-screen.dart';

import 'package:shopify/utils/app_constants.dart';

import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      checkUserLoggedIn(context);
    });
  }

  Future<void> checkUserLoggedIn(BuildContext context) async {
    if (user != null) {
      final GetUserdataController getUserdataController = Get.put(
        GetUserdataController(),
      );
      var userData = await getUserdataController.getUserData(user!.uid);
      if(userData[0]['isAdmin']==true){
        Get.offAll(()=>AdminMainScreen());
      }else{
        Get.offAll(()=>MainScreen());
      }
    } else {
      Get.to(() => WelcomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppConstants.appSecondaryColour,
      appBar: AppBar(
        backgroundColor: AppConstants.appSecondaryColour,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: Get.width,
                alignment: Alignment.center,
                child: Lottie.asset('assets/images/splash.json'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              width: Get.width,
              alignment: Alignment.center,
              child: Text(
                AppConstants.appPoweredBy,
                style: TextStyle(
                  fontSize: 24,
                  color: AppConstants.appTextColour,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
