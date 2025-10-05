

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shopify/utils/app_constants.dart';

class GetDeviceToken  extends GetxController{
  String? deviceToken;

  @override
  void onInit(){
    super.onInit();
    getDeviceToken();


  }
  Future<void> getDeviceToken()async{
try{
// ignore: unused_local_variable
String? token = await FirebaseMessaging.instance.getToken();
if(token!=null){
  deviceToken= token;
  update();
  
}

}catch(e){
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