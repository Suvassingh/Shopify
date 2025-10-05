


import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import 'package:shopify/models/product_model.dart';
import 'package:shopify/screens/user_pannel/product_details_screen.dart';
import 'package:shopify/utils/app_constants.dart';

class SpecificFlashsaleScreen extends StatefulWidget {
  const SpecificFlashsaleScreen({super.key});

  @override
  State<SpecificFlashsaleScreen> createState() => _SpecificFlashsaleScreenState();
}

class _SpecificFlashsaleScreenState extends State<SpecificFlashsaleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flash Sale Product",
          style: TextStyle(
            color: AppConstants.appTextColour,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppConstants.appMainColour,
        iconTheme: IconThemeData(color: AppConstants.appTextColour),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('products').where('isSale',isEqualTo: true).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: Get.height / 5,
              child: Center(child: CupertinoActivityIndicator()),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No flash sale found!",style: TextStyle(color: AppConstants.appSecondaryColour,fontSize: 16,fontWeight: FontWeight.bold),));
          }

          if (snapshot.data != null) {
            return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
                childAspectRatio: 1.19,
              ),
              itemBuilder: (context, index) {
                final productData = snapshot.data!.docs[index];
               ProductModel productModel = ProductModel(
                productId: productData['productId'], 
                categoryId: productData['categoryId'], 
                productName: productData['productName'],
                 categoryName: productData['categoryName'], 
                 salePrice: productData['salePrice'], 
                 fullPrice: productData['fullPrice'], 
                 productImages: productData['productImages'], 
                 deliveryTime: productData['deliveryTime'], 
                 isSale: productData['isSale'], productDescription: productData['productDescription'], 
                 createdAt: productData['createdAt'], 
                 updatedAt: productData['updatedAt']);
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(
                        () => ProductDetailsScreen(productModel: productModel),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          child: FillImageCard(
                            borderRadius: 20.0,
                            width: Get.width / 2.3,
                            heightImage: Get.height / 10,
                            imageProvider: CachedNetworkImageProvider(
                              productModel.productImages[0],
                            ),
                            title: Center(
                              child: Text(
                                productModel.productName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}