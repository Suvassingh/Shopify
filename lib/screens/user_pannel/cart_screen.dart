import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:shopify/models/cart_model.dart';
import 'package:shopify/utils/app_constants.dart';

import '../../models/product_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart Screen",
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
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('cart')
            .doc(user!.uid)
            .collection('cartOrders')
            .get(),
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
            itemCount: snapshot.data!.docs.length ,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final productData = snapshot.data!.docs[index];
                    CartModel cartModel = CartModel(
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
                    );
              return Card(
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppConstants.appMainColour,
                    backgroundImage: NetworkImage(cartModel.productImages[0]),
                  ),
                  title: Text(cartModel.productName),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(cartModel.isSale ? cartModel.salePrice : cartModel.fullPrice),
                      SizedBox(width: 95,),
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: AppConstants.appMainColour,
                        child: Text("-"),),
                        SizedBox(width: Get.width/20),
                        CircleAvatar(
                        radius: 14,
                        backgroundColor: AppConstants.appMainColour,
                        child: Text("+"),
                      )
                    ],
                  ),
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
      
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            
            SizedBox(width: Get.width / 40),
            Text("Total : 23"),
            SizedBox(width: Get.width / 3.5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                child: Container(
                  width: Get.width / 2,
                  height: Get.height / 18,
                  decoration: BoxDecoration(
                    color: AppConstants.appSecondaryColour,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton.icon(
                    icon: Image.asset(
                      'assets/images/buy-button.png',
                      height: 34,
                      width: 34,
                    ),
                    onPressed: () {
                      // Get.to(() => SigninScreen());
                    },
                    label: Text(
                      "Check out",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.appTextColour,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
