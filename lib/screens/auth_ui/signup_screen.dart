import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:shopify/services/notification_service.dart';
import '../../controllers/signup_controlller.dart';
import 'signin_screen.dart';
import '../../utils/app_constants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignupControlller signupControlller = Get.put(SignupControlller());
  TextEditingController username = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userCity = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(height: Get.height / 20),
                  Text(
                    "Welcome to Shopify",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.appSecondaryColour,
                    ),
                  ),
                  SizedBox(height: Get.height / 20),
                  _buildTextField(
                    controller: username,
                    hint: "Name",
                    icon: Icons.person,
                  ),
                  SizedBox(height: Get.height / 100),
                  _buildTextField(
                    controller: userEmail,
                    hint: "Email",
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: Get.height / 100),
                  _buildTextField(
                    controller: userPhone,
                    hint: "Phone",
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: Get.height / 100),
                  _buildTextField(
                    controller: userCity,
                    hint: "City",
                    icon: Icons.location_pin,
                    keyboardType: TextInputType.streetAddress,
                  ),
                  SizedBox(height: Get.height / 100),
                  Obx(
                    () => _buildTextField(
                      controller: userPassword,
                      hint: "Password",
                      icon: Icons.password,
                      obscureText: signupControlller.isPasswordVisible.value,
                      suffixIcon: GestureDetector(
                        onTap: () =>
                            signupControlller.isPasswordVisible.toggle(),
                        child: Icon(
                          signupControlller.isPasswordVisible.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height / 40),
                  Container(
                    width: Get.width / 2,
                    height: Get.height / 18,
                    decoration: BoxDecoration(
                      color: AppConstants.appSecondaryColour,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        NotificationService notificationService = NotificationService();
                        String name = username.text.trim();
                        String email = userEmail.text.trim();
                        String phone = userPhone.text.trim();
                        String city = userCity.text.trim();
                        String password = userPassword.text.trim();
                        String userDeviceToken =await notificationService.getDeviceToken();

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
                              backgroundColor: AppConstants.appSecondaryColour,
                              colorText: AppConstants.appTextColour,
                            );
                            FirebaseAuth.instance.signOut();
                            Get.offAll(() => SigninScreen());
                          }
                        }
                      },
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
                  SizedBox(height: Get.height / 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        cursorColor: AppConstants.appSecondaryColour,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.only(top: 2, left: 8),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
