import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopify/screens/auth_ui/welcome_screen.dart';
import 'package:shopify/utils/app_constants.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.appMainColour,
        title: Text(AppConstants.appName),
        centerTitle: true,
        elevation: 0,
        actions: [GestureDetector(
          onTap: ()async {

            GoogleSignIn googleSignIn = GoogleSignIn();
            FirebaseAuth _auth = FirebaseAuth.instance;
            await _auth.signOut();
           await googleSignIn.signOut();
            Get.offAll(()=>WelcomeScreen());
          } ,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.logout),
          ),
        )],
        
      ),
     
    );
  }
}