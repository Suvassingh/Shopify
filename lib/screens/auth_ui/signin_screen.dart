import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shopify/screens/auth_ui/forget_password_screen.dart';
import '../../controllers/signin_controller.dart';
import '../../screens/user_pannel/main-screen.dart';
import 'signup_screen.dart';
import '../../utils/app_constants.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final SigninController signinController = Get.put(SigninController());
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardvisible) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Sign In",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppConstants.appTextColour,
              ),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white, // <-- makes the back arrow white
            ),
            centerTitle: true,
            backgroundColor: AppConstants.appMainColour,
          ),
          body: Container(
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(height: Get.height / 50),
                    isKeyboardvisible
                        ? Text(
                            "Welcome to shopify",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          )
                        : Lottie.asset('assets/images/splash.json'),
                  ],
                ),
                SizedBox(height: Get.height / 500),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: userEmail,
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
                    child: Obx(
                      () => TextFormField(
                        controller: userPassword,
                        obscureText: signinController.isPasswordVisible.value,
                        cursorColor: AppConstants.appSecondaryColour,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              signinController.isPasswordVisible.toggle();
                            },
                            child: signinController.isPasswordVisible.value
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
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
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () => Get.to(()=>ForgetPasswordScreen()),
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                        color: AppConstants.appSecondaryColour,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height / 120),
                Material(
                  child: Container(
                    width: Get.width / 2,
                    height: Get.height / 18,
                    decoration: BoxDecoration(
                      color: AppConstants.appSecondaryColour,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        String email = userEmail.text.trim();
                        String password = userPassword.text.trim();
                        if (email.isEmpty || password.isEmpty) {
                          Get.snackbar(
                            "Error",
                            'please fill all fields',
                            snackPosition: SnackPosition.TOP,
                            colorText: AppConstants.appTextColour,
                            backgroundColor: AppConstants.appSecondaryColour,
                          );
                        } else {
                          UserCredential? userCredential =
                              await signinController.signInMethod(
                                email,
                                password,
                              );
                          if (userCredential != null) {
                            if (userCredential.user!.emailVerified) {
                               Get.snackbar(
                                "Success",
                                'Logged in successfully...',
                                snackPosition: SnackPosition.TOP,
                                colorText: AppConstants.appTextColour,
                                backgroundColor:
                                    AppConstants.appSecondaryColour,
                              );
                              Get.offAll(()=>MainScreen());
                            } else {
                              Get.snackbar(
                                "Error",
                                'please verify your email before login...',
                                snackPosition: SnackPosition.TOP,
                                colorText: AppConstants.appTextColour,
                                backgroundColor:
                                    AppConstants.appSecondaryColour,
                              );
                            }
                          }else{
                             Get.snackbar(
                              "Error",
                              'please try again',
                              snackPosition: SnackPosition.TOP,
                              colorText: AppConstants.appTextColour,
                              backgroundColor: AppConstants.appSecondaryColour,
                            );
                          }
                        }
                      },
                      child: Text(
                        "Sign In",
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
                      "Don't have an account?",
                      style: TextStyle(
                        color: AppConstants.appSecondaryColour,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: Get.width / 55),
                    GestureDetector(
                      onTap: () => Get.offAll(() => SignupScreen()),
                      child: Text(
                        "Sign Up",
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
        );
      },
    );
  }
}
