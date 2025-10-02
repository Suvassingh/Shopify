import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shopify/screens/auth_ui/signin_screen.dart';
import '../../utils/app_constants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardvisible) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppConstants.appTextColour,
              ),
            ),
            centerTitle: true,
            backgroundColor: AppConstants.appMainColour,
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: Get.height / 20),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Welcome to shopify",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.appSecondaryColour,
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height / 20),
            
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        cursorColor: AppConstants.appSecondaryColour,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Name",
                          prefixIcon: Icon(Icons.person),
                          contentPadding: EdgeInsets.only(top: 2, left: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
            
                  SizedBox(height: Get.height / 500),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        cursorColor: AppConstants.appSecondaryColour,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email),
                          contentPadding: EdgeInsets.only(top: 2, left: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
            


                  SizedBox(height: Get.height / 500),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        cursorColor: AppConstants.appSecondaryColour,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: "Phone",
                          prefixIcon: Icon(Icons.phone),
                          contentPadding: EdgeInsets.only(top: 2, left: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
            


SizedBox(height: Get.height / 500),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        cursorColor: AppConstants.appSecondaryColour,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          hintText: "City",
                          prefixIcon: Icon(Icons.location_pin ),
                          contentPadding: EdgeInsets.only(top: 2, left: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),





                  SizedBox(height: Get.height / 500),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        cursorColor: AppConstants.appSecondaryColour,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.visibility_off),
                          hintText: "Password",
                          prefixIcon: Icon(Icons.password),
                          contentPadding: EdgeInsets.only(top: 2, left: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height / 20),
                  Material(
                    child: Container(
                      width: Get.width / 2,
                      height: Get.height / 18,
                      decoration: BoxDecoration(
                        color: AppConstants.appSecondaryColour,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: AppConstants.appTextColour,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height / 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
            
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: AppConstants.appSecondaryColour,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: Get.width / 55),
                      GestureDetector(
                        onTap: () => Get.offAll(() => SigninScreen()),
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: AppConstants.appSecondaryColour,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
