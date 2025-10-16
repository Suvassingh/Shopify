
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class NotificationController  extends GetxController{
User? user = FirebaseAuth.instance.currentUser;

var notifictionCount = 0.obs;
@override
void onInit(){
  super.onInit();
  fetchNotificationCount();
}
// 
void fetchNotificationCount(){
  FirebaseFirestore.instance.collection('notifications').doc(user!.uid).collection('notification').where("isSeen",isEqualTo: false).snapshots().listen((QuerySnapshot querySnapshot){
          notifictionCount.value = querySnapshot.docs.length;
          print("Notification length=>${notifictionCount.value}");
          update();
  });
}
}