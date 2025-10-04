import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify/utils/app_constants.dart';
import 'package:shopify/widgets/banner_widget.dart';
import 'package:shopify/widgets/custom_drawer_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstants.appTextColour),
        backgroundColor: AppConstants.appMainColour,
        title: Text(AppConstants.appName,style: TextStyle(color: AppConstants.appTextColour,fontWeight: FontWeight.bold),),
        centerTitle: true,
        elevation: 0,
      
      ),
      drawer: CustomDrawerWidget(),
     body: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        
        child: Column(
          
          children: [
            SizedBox(height: Get.height/90,),
          //  banners
          BannerWidget()


          ],
        ),
      ),
     ),
    );
  }
}