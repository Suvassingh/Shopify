import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify/screens/user_pannel/all_categories_screen.dart';
import 'package:shopify/screens/user_pannel/all_product_screen.dart';
import 'package:shopify/screens/user_pannel/cart_screen.dart';
import 'package:shopify/screens/user_pannel/specific_flashsale_screen.dart';
import 'package:shopify/services/fcm_service.dart';
import 'package:shopify/services/notification_service.dart';
import 'package:shopify/utils/app_constants.dart';
import 'package:shopify/widgets/all_product_widget.dart';
import 'package:shopify/widgets/banner_widget.dart';
import 'package:shopify/widgets/category_widget.dart';
import 'package:shopify/widgets/custom_drawer_widget.dart';
import 'package:shopify/widgets/flash_sale_widget.dart';
import 'package:shopify/widgets/heading_widget.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  NotificationService notificationService = NotificationService();
  @override
  void initState(){
    super.initState();
    notificationService.requestNotificationPermission();
    notificationService.getDeviceToken();
    FcmService.firebaseInit();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstants.appTextColour),
        backgroundColor: AppConstants.appMainColour,
        title: Text(AppConstants.appName,style: TextStyle(color: AppConstants.appTextColour,fontWeight: FontWeight.bold),),
        centerTitle: true,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: ()=>Get.to(()=>CartScreen()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_cart),
            ),
          )
        ],
      
      ),
      drawer: CustomDrawerWidget(),
     body: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      // ignore: avoid_unnecessary_containers
      child: Container(
        
        child: Column(
          
          children: [
            SizedBox(height: Get.height/90,),
          //  banners
          BannerWidget(),
          // heading_widget
          HeadingWidget(
            headingTitle: "Categories",
            headingSubTitle: "According to your  budget",
            onTap: ()=> Get.to(AllCategoriesScreen()),
            buttonText: "See More >",
          ),
        
        CategoriesWidget(),
         HeadingWidget(
                headingTitle: "Flash Sale",
                headingSubTitle: "According to your  budget",
                onTap: ()=>Get.to(()=>SpecificFlashsaleScreen()),
                buttonText: "See More >",
              ),
              FlashSaleWidget(),
              HeadingWidget(
                headingTitle: "All Products",
                headingSubTitle: "According to your  budget",
                onTap: () => Get.to(() => AllProductScreen()),
                buttonText: "See More >",
              ),
              AllProductWidget(),
          ],
        ),
      ),
     ),
    );
  }
}