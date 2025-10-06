import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:shopify/controllers/cart_price_controller.dart';
import 'package:shopify/models/cart_model.dart';
import 'package:shopify/models/order_model.dart';
import 'package:shopify/screens/user_pannel/checkout_screen.dart';
import 'package:shopify/screens/user_pannel/review_screen.dart';
import 'package:shopify/utils/app_constants.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  final CartPriceController cartPriceController = Get.put(
    CartPriceController(),
  );
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All orders Screen",
          style: TextStyle(
            color: AppConstants.appTextColour,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: AppConstants.appTextColour),
        centerTitle: true,
        backgroundColor: AppConstants.appMainColour,
      ),
      // ignore: avoid_unnecessary_containers
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .doc(user!.uid)
            .collection('confirmOrders')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            // ignore: sized_box_for_whitespace
            return Container(
              height: Get.height / 5,
              child: Center(child: CupertinoActivityIndicator()),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No products found!"));
          }

          if (snapshot.data != null) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final productData = snapshot.data!.docs[index];
                    OrderModel orderModel = OrderModel(
                      productId: productData['productId'],
                      categoryId: productData['categoryId'],
                      productName: productData['productName'],
                      categoryName: productData['categoryName'],
                      salePrice: productData['salePrice'],
                      fullPrice: productData['fullPrice'],
                      productImages: productData['productImages'],
                      deliveryTime: productData['deliveryTime'],
                      isSale: productData['isSale'],
                      productDescription: productData['productDescription'],
                      createdAt: productData['createdAt'],
                      updatedAt: productData['updatedAt'],
                      productQuantity: productData['productQuantity'],
                      productTotalPrice: productData['productTotalPrice'],
                      customerId: productData['customerId'],
                      status:productData['status'] ,
                      customerName: productData['customerName'],
                      customerPhone:productData['customerPhone'] ,
                      customerAddress:productData['customerAddress'] ,
                      customerDeviceToken: productData['customerDeviceToken'] ,
                    );
                    // calculate Price
                    cartPriceController.fetchProductsPrice();
                    return Card(
                        elevation: 5,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppConstants.appMainColour,
                            backgroundImage: NetworkImage(
                              orderModel.productImages[0],
                            ),
                          ),
                          title: Text(orderModel.productName),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(orderModel.productTotalPrice.toString()),
                              orderModel.status!=true?Text("Pending..."):Text("Delivered")
                             
                            ],
                          ),
                          trailing: orderModel.status==true? ElevatedButton(onPressed: ()=>Get.to(()=>ReviewScreen(
                            orderModel:orderModel
                          )), child: Text("Review")):SizedBox.shrink(),
                        ),
                      );
                  },
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
