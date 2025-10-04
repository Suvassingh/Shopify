import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopify/screens/user_pannel/main-screen.dart';
import '../models/user-model.dart';

class GoogleSigninController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  // ignore: unused_field
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> signInWithGoogle() async {
    try {
      // ignore: unused_local_variable
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn
          .signIn();
      if (googleSignInAccount != null) {
        EasyLoading.show(status: "please wait...");
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential = await _auth.signInWithCredential(credential);
        final User? user = UserCredential.user;
        if (user != null){
          UserModel userModel = UserModel(uId: user.uid, 
          username: user.displayName.toString(), email: user.email.toString(), 
          phone: user.phoneNumber.toString(),
          userImg: user.photoURL.toString(), 
          userDeviceToken: "",
          country: "",
          userAddress: "",
          street: "", 
          isAdmin: false, 
          isActive: true,
          createdOn: DateTime.now(), 
          city: "");
         await FirebaseFirestore.instance.collection('users').doc(user.uid).set(userModel.toMap());
         EasyLoading.dismiss();
         Get.offAll(()=>const MainScreen());
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      print("error $e");
    }
  }
}
