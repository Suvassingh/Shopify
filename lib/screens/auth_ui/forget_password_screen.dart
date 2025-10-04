import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../controllers/forget_password_controller.dart';
import '../../utils/app_constants.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final ForgetPasswordController forgetPasswordController = Get.put(ForgetPasswordController());
  final TextEditingController userEmail = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardvisible) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Forget Password",
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
                      child: Text(
                        "Forget",style: TextStyle(color: AppConstants.appTextColour),
                      ),
                      onPressed: () async {
                        String email = userEmail.text.trim();
                        
                        if (email.isEmpty) {
                          Get.snackbar(
                            "Error",
                            'please fill all fields',
                            snackPosition: SnackPosition.TOP,
                            colorText: AppConstants.appTextColour,
                            backgroundColor: AppConstants.appSecondaryColour,
                          );
                        }else{
                          String email = userEmail.text.trim();
                        forgetPasswordController.forgetPasswordMethod(email);
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: Get.height / 50),
              ],
            ),
          ),
        );
      },
    );
  }
}
