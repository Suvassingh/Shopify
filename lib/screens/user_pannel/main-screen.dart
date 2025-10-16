import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopify/screens/user_pannel/all_categories_screen.dart';
import 'package:shopify/screens/user_pannel/all_product_screen.dart';
import 'package:shopify/screens/user_pannel/cart_screen.dart';
import 'package:shopify/screens/user_pannel/specific_flashsale_screen.dart';
import 'package:shopify/services/fcm_service.dart';
import 'package:shopify/services/notification_screen.dart';
import 'package:shopify/services/notification_service.dart';
import 'package:shopify/services/send_notification_service.dart';
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
  void initState() {
    super.initState();
    notificationService.requestNotificationPermission();
    notificationService.getDeviceToken();
    FcmService.firebaseInit();
    notificationService.firebaseInit(context);
    notificationService.setupInteractMessage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstants.appTextColour),
        backgroundColor: AppConstants.appMainColour,
        title: Text(
          AppConstants.appName,
          style: TextStyle(
            color: AppConstants.appTextColour,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => NotificationScreen());
            },
            child: Icon(Icons.notifications),
          ),
          GestureDetector(
            onTap: () => Get.to(() => CartScreen()),
            // onTap: ()async{
            //   EasyLoading.show(status: "Sending Notification");
            //  await SendNotificationService.sendNotificationUsingApi(token: "cl3IwP9cTkCSHk31yOgVYJ:APA91bEG5VW7eVxEP5XDxyfDcheuiQPfa0EOZBggf-0fHDj9091iAO4KeTIF8F0j3TY8Jy4lWc8M53zmxbfC-EQG6XfccKp2ArFZpaUCNOqZ1cqG-4nZa7E", title: "notofication title", body: "notofication body", data: {
            //   "Screen":"cart"
            //  });
            //  EasyLoading.dismiss();
            // },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      drawer: CustomDrawerWidget(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: Column(
            children: [
              SizedBox(height: Get.height / 90),
              //  banners
              BannerWidget(),
              // heading_widget
              HeadingWidget(
                headingTitle: "Categories",
                headingSubTitle: "According to your  budget",
                onTap: () => Get.to(AllCategoriesScreen()),
                buttonText: "See More >",
              ),

              CategoriesWidget(),
              HeadingWidget(
                headingTitle: "Flash Sale",
                headingSubTitle: "According to your  budget",
                onTap: () => Get.to(() => SpecificFlashsaleScreen()),
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
