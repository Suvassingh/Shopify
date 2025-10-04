
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

import 'package:shopify/utils/app_constants.dart';

import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 5), (){
      Get.offAll(()=> WelcomeScreen());
    });
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
              child: Text(AppConstants.appPoweredBy,style: TextStyle(fontSize: 24,color: AppConstants.appTextColour,fontWeight: FontWeight.bold),),
            )
          ],
        ),
      ),
    );
  }
}