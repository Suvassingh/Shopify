import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopify/models/order_model.dart';
import 'package:shopify/screens/user_pannel/main-screen.dart';
import 'package:shopify/services/generate_order_id_service.dart';
import 'package:shopify/utils/app_constants.dart';

void placeOrder({
  required BuildContext context,
  required String customerName,
  required String customerPhone,
  required String customerAddress,
  required String customerDeviceToken,
}) async {
  final user = FirebaseAuth.instance.currentUser;
  EasyLoading.show(status: "Please Wait ");
  if (user != null) {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cart')
          .doc(user.uid)
          .collection('cartOrders')
          .get();
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;
      for (var doc in documents) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;

        String orderId = generateOrderId();
        OrderModel orderModel = OrderModel(
          productId: data['productId'],
          categoryId: data['categoryId'],
          productName: data['productName'],
          categoryName: data['categoryName'],
          salePrice: data['salePrice'],
          fullPrice: data['fullPrice'],
          productImages: data['productImages'],
          deliveryTime: data['deliveryTime'],
          isSale: data['isSale'],
          productDescription: data['productDescription'],
          createdAt: DateTime.now(),
          updatedAt: data['updatedAt'],
          productQuantity: data['productQuantity'],
          productTotalPrice: double.parse(data['productTotalPrice'].toString()),
          customerId: user.uid,
          status: false,
          customerName: customerName,
          customerPhone: customerPhone,
          customerAddress: customerAddress,
          customerDeviceToken: customerDeviceToken,
        );
        for(var x = 0; x < documents.length; x++){
          await FirebaseFirestore.instance.collection('orders').doc(user.uid).set({
            'uId':user.uid,
            'customerName':customerName,
            'customerPhone':customerPhone,
            'customerAddress':customerAddress,
            'customerDeviceToken':customerDeviceToken,
            'orderStatus':false,
            'createdAt':DateTime.now(),

          });
          // upload order
        await  FirebaseFirestore.instance.collection('orders').doc(user.uid).collection('confirmOrders').doc(orderId).set(orderModel.toMap());

          // delete cart productData
         await FirebaseFirestore.instance.collection('cart').doc(user.uid).collection('cartOrders').doc(orderModel.productId.toString()).delete().then((value){
          print('delete cart product $orderModel.productId.toString()');
         });
        }
      }
      print("order confirmed");
      Get.snackbar("Oder confirmed","Thank you for your order",
      backgroundColor: AppConstants.appSecondaryColour,
      colorText: Colors.white,
      duration:  Duration(seconds: 3),
      );
      EasyLoading.dismiss();
      Get.offAll(()=>MainScreen());
    } catch (e) {
      print("Error $e");
    }
  }
}
