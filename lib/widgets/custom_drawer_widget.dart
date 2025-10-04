import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopify/utils/app_constants.dart';

import '../screens/auth_ui/welcome_screen.dart';

class CustomDrawerWidget extends StatefulWidget {
  const CustomDrawerWidget({super.key});

  @override
  State<CustomDrawerWidget> createState() => _CustomDrawerWidgetState();
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25),
      child: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        // ignore: sort_child_properties_last
        child: Wrap(
          runSpacing: 10,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Suvas",
                  style: TextStyle(color: AppConstants.appTextColour),
                ),
                subtitle: Text(
                  "version 1.0",
                  style: TextStyle(color: AppConstants.appTextColour),
                ),
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppConstants.appMainColour,
                  child: Text(
                    "w",
                    style: TextStyle(color: AppConstants.appTextColour),
                  ),
                ),
              ),
            ),
            Divider(
              indent: 10,
              endIndent: 10,
              thickness: 1.5,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Home",
                  style: TextStyle(color: AppConstants.appTextColour),
                ),
                leading: Icon(Icons.home, color: AppConstants.appTextColour),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: AppConstants.appTextColour,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Product",
                  style: TextStyle(color: AppConstants.appTextColour),
                ),
                leading: Icon(
                  Icons.production_quantity_limits,
                  color: AppConstants.appTextColour,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: AppConstants.appTextColour,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Orders",
                  style: TextStyle(color: AppConstants.appTextColour),
                ),
                leading: Icon(
                  Icons.shopping_bag,
                  color: AppConstants.appTextColour,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: AppConstants.appTextColour,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Contacts",
                  style: TextStyle(color: AppConstants.appTextColour),
                ),
                leading: Icon(
                  Icons.contact_emergency,
                  color: AppConstants.appTextColour,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: AppConstants.appTextColour,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                onTap: () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  FirebaseAuth _auth = FirebaseAuth.instance;
                  await _auth.signOut();
                  await googleSignIn.signOut();
                  Get.offAll(() => WelcomeScreen());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Logout",
                  style: TextStyle(color: AppConstants.appTextColour),
                ),
                leading: Icon(Icons.logout, color: AppConstants.appTextColour),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: AppConstants.appTextColour,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppConstants.appSecondaryColour,
      ),
    );
  }
}
