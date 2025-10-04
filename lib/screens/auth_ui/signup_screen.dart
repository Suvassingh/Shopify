<<<<<<< HEAD
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import '../../controllers/signup_controlller.dart';
import 'signin_screen.dart';
=======
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shopify/screens/auth_ui/signin_screen.dart';
>>>>>>> 1e4db88fdb7272423e90a3ffcad881be9a8e1e67
import '../../utils/app_constants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
<<<<<<< HEAD
  final SignupControlller signupControlller = Get.put(SignupControlller());
  TextEditingController username = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userCity = TextEditingController();
  TextEditingController userPassword = TextEditingController();
=======
>>>>>>> 1e4db88fdb7272423e90a3ffcad881be9a8e1e67
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
<<<<<<< HEAD

=======
            
>>>>>>> 1e4db88fdb7272423e90a3ffcad881be9a8e1e67
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
<<<<<<< HEAD
                        controller: username,
=======
>>>>>>> 1e4db88fdb7272423e90a3ffcad881be9a8e1e67
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
<<<<<<< HEAD

=======
            
>>>>>>> 1e4db88fdb7272423e90a3ffcad881be9a8e1e67
                  SizedBox(height: Get.height / 500),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
<<<<<<< HEAD
                        controller: userEmail,
=======
>>>>>>> 1e4db88fdb7272423e90a3ffcad881be9a8e1e67
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
<<<<<<< HEAD
=======
            

>>>>>>> 1e4db88fdb7272423e90a3ffcad881be9a8e1e67

                  SizedBox(height: Get.height / 500),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
<<<<<<< HEAD
                        controller: userPhone,

=======
>>>>>>> 1e4db88fdb7272423e90a3ffcad881be9a8e1e67
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
<<<<<<< HEAD

                  SizedBox(height: Get.height / 500),
=======
            


SizedBox(height: Get.height / 500),
>>>>>>> 1e4db88fdb7272423e90a3ffcad881be9a8e1e67
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
<<<<<<< HEAD
                        controller: userCity,
=======
>>>>>>> 1e4db88fdb7272423e90a3ffcad881be9a8e1e67
                        cursorColor: AppConstants.appSecondaryColour,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          hintText: "City",
<<<<<<< HEAD
                          prefixIcon: Icon(Icons.location_pin),
=======
                          prefixIcon: Icon(Icons.location_pin ),
>>>>>>> 1e4db88fdb7272423e90a3ffcad881be9a8e1e67
                          contentPadding: EdgeInsets.only(top: 2, left: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),

<<<<<<< HEAD
=======




>>>>>>> 1e4db88fdb7272423e90a3ffcad881be9a8e1e67
                  SizedBox(height: Get.height / 500),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
<<<<<<< HEAD
                      child: Obx(
                        () => TextFormField(
                          controller: userPassword,
                          obscureText:
                              signupControlller.isPasswordVisible.value,
                          cursorColor: AppConstants.appSecondaryColour,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                signupControlller.isPasswordVisible.toggle();
                              },
                              child: signupControlller.isPasswordVisible.value
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                            ),
                            hintText: "Password",
                            prefixIcon: Icon(Icons.password),
                            contentPadding: EdgeInsets.only(top: 2, left: 8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
=======
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
>>>>>>> 1e4db88fdb7272423e90a3ffcad881be9a8e1e67
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
<<<<<<< HEAD
                        onPressed: () async {
                          String name = username.text.trim();
                          String email = userEmail.text.trim();
                          String phone = userPhone.text.trim();
                          String city = userCity.text.trim();
                          String password = userPassword.text.trim();
                          String userDeviceToken = "";
                          if (name.isEmpty ||
                              email.isEmpty ||
                              phone.isEmpty ||
                              city.isEmpty ||
                              password.isEmpty) {
                            Get.snackbar(
                              'Error',
                              'Please enter all details...',
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: AppConstants.appSecondaryColour,
                              colorText: AppConstants.appTextColour,
                            );
                          } else {
                            UserCredential? userCredential =
                                await signupControlller.signUpMethod(
                                  name,
                                  email,
                                  phone,
                                  city,
                                  password,
                                  userDeviceToken,
                                );
                            if (userCredential != null) {
                              Get.snackbar(
                                'Verification Email Sent',
                                'Please check your email...',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor:
                                    AppConstants.appSecondaryColour,
                                colorText: AppConstants.appTextColour,
                              );
                              FirebaseAuth.instance.signOut();
                              Get.offAll(()=>SigninScreen());
                            }
                          }
                        },
=======
                        onPressed: () {},
>>>>>>> 1e4db88fdb7272423e90a3ffcad881be9a8e1e67
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
<<<<<<< HEAD

=======
            
>>>>>>> 1e4db88fdb7272423e90a3ffcad881be9a8e1e67
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
