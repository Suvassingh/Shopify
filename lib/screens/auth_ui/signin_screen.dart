
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shopify/screens/admin_pannel/admin_main_screen.dart';
import 'package:shopify/screens/auth_ui/forget_password_screen.dart';
import '../../controllers/signin_controller.dart';
import '../../screens/user_pannel/main-screen.dart';
import 'signup_screen.dart';
import '../../utils/app_constants.dart';
import '../../controllers/get_userdata_controller.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  // Make controllers permanent so they persist after navigation
  final SigninController signinController =
      Get.put(SigninController(), permanent: true);
  final GetUserdataController getUserdataController =
      Get.put(GetUserdataController(), permanent: true);

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
          body: Column(
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

              // Email input
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: userEmail,
                    cursorColor: AppConstants.appSecondaryColour,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: const Icon(Icons.email),
                      contentPadding: const EdgeInsets.only(top: 2, left: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),

              // Password input
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
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
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                        hintText: "Password",
                        prefixIcon: const Icon(Icons.password),
                        contentPadding:
                            const EdgeInsets.only(top: 2, left: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Forget password
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                  onTap: () => Get.to(() => const ForgetPasswordScreen()),
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

              // Sign in button
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
                          'Please fill all fields',
                          snackPosition: SnackPosition.TOP,
                          colorText: AppConstants.appTextColour,
                          backgroundColor: AppConstants.appSecondaryColour,
                        );
                        return;
                      }

                      try {
                        UserCredential? userCredential =
                            await signinController.signInMethod(email, password);

                        if (userCredential == null ||
                            userCredential.user == null) {
                          Get.snackbar(
                            "Error",
                            'Login failed. Please try again.',
                            snackPosition: SnackPosition.TOP,
                            colorText: AppConstants.appTextColour,
                            backgroundColor: AppConstants.appSecondaryColour,
                          );
                          return;
                        }

                        if (!userCredential.user!.emailVerified) {
                          Get.snackbar(
                            "Error",
                            'Please verify your email before login...',
                            snackPosition: SnackPosition.TOP,
                            colorText: AppConstants.appTextColour,
                            backgroundColor: AppConstants.appSecondaryColour,
                          );
                          return;
                        }

                        // Fetch user data from Firestore
                        var userData = await getUserdataController
                            .getUserData(userCredential.user!.uid);

                        if (userData.isNotEmpty &&
                            userData[0]['isAdmin'] == true) {
                          Get.offAll(() => const AdminMainScreen());
                          Get.snackbar(
                            "Success",
                            'Logged in as admin successfully...',
                            snackPosition: SnackPosition.TOP,
                            colorText: AppConstants.appTextColour,
                            backgroundColor: AppConstants.appSecondaryColour,
                          );
                        } else {
                          Get.offAll(() => const MainScreen());
                          Get.snackbar(
                            "Success",
                            'Logged in as user successfully...',
                            snackPosition: SnackPosition.TOP,
                            colorText: AppConstants.appTextColour,
                            backgroundColor: AppConstants.appSecondaryColour,
                          );
                        }
                      } catch (e) {
                        Get.snackbar(
                          "Error",
                          'An error occurred: $e',
                          snackPosition: SnackPosition.TOP,
                          colorText: AppConstants.appTextColour,
                          backgroundColor: AppConstants.appSecondaryColour,
                        );
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

              // Sign up redirect
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
                    onTap: () => Get.offAll(() => const SignupScreen()),
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
        );
      },
    );
  }
}
