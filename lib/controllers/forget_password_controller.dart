// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopify/screens/auth_ui/signin_screen.dart';
import 'package:shopify/utils/app_constants.dart';

class ForgetPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  

  Future<void> forgetPasswordMethod(
    String userEmail,
  ) async {
    try {
      EasyLoading.show(status: "please wait...");
await _auth.sendPasswordResetEmail(email: userEmail);
Get.snackbar(
        "Request Sent Successfully",
        "Password reset link sent to $userEmail",
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppConstants.appSecondaryColour,
        colorText: AppConstants.appTextColour,
      );
Get.offAll(()=>SigninScreen());
      EasyLoading.dismiss();
      
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        "Error",
        "$e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppConstants.appSecondaryColour,
        colorText: AppConstants.appTextColour,
      );
    }
  }
}
