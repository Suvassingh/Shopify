import 'package:flutter/material.dart';
import 'package:shopify/utils/app_constants.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.appMainColour,
        title: Text(AppConstants.appName),
        centerTitle: true,
        elevation: 0,
        
      ),
     
    );
  }
}