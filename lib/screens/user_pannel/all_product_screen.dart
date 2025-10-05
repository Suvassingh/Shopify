import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:shopify/models/product_model.dart';
import 'package:shopify/screens/user_pannel/product_details_screen.dart';
import 'package:shopify/utils/app_constants.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Products",style: TextStyle(color: AppConstants.appTextColour,fontWeight: FontWeight.bold),),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppConstants.appTextColour),
        backgroundColor: AppConstants.appMainColour,

      ),
      body:FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('products')
          .where('isSale', isEqualTo: false)
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
          return GridView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 0.80,
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
                isSale: productData['isSale'],
                productDescription: productData['productDescription'],
                createdAt: productData['createdAt'],
                updatedAt: productData['updatedAt'],
              );
              return Row(
                children: [
                  GestureDetector(
                    onTap: ()=>Get.to(()=>ProductDetailsScreen(productModel:productModel)),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      // ignore: avoid_unnecessary_containers
                      child: Container(
                        child: FillImageCard(
                          borderRadius: 20.0,
                          width: Get.width / 2.3,
                          heightImage: Get.height / 6,
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
                          footer:
                              // ignore: prefer_interpolation_to_compose_strings
                              Center(
                                child: Text("Rs " + productModel.fullPrice),
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
