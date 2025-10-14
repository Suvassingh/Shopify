import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class FcmService {
  static void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification!.title);
      print(message.notification!.body);
    });
  }
}
