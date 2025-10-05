// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify/models/product_model.dart';
import 'package:shopify/utils/app_constants.dart';

// ignore: must_be_immutable
class ProductDetailsScreen extends StatefulWidget {
  ProductModel productModel;
  ProductDetailsScreen({super.key, required this.productModel});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productModel.productName,style: TextStyle(color: AppConstants.appTextColour,fontWeight: FontWeight.bold),),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppConstants.appTextColour),
        
        backgroundColor: AppConstants.appMainColour,
      ),
      body: Container(
        child: Column(
          children: [
            // product productImages
            SizedBox(height: Get.height / 60),
            CarouselSlider(
              items: widget.productModel.productImages
                  .map(
                    (imageurls) => ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: imageurls,
                        fit: BoxFit.cover,
                        width: Get.width - 10,
                        placeholder: (context, url) => ColoredBox(
                          color: Colors.white,
                          child: Center(child: CupertinoActivityIndicator()),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                aspectRatio: 2.5,
                viewportFraction: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Product Name : " +
                                  widget.productModel.productName,
                            ),
                            Icon(Icons.favorite_outline),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Category Name : " + widget.productModel.categoryName,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            widget.productModel.isSale==true && widget.productModel.salePrice !=""?
                            Text("Rs " + widget.productModel.salePrice): Text("Rs " + widget.productModel.fullPrice),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(widget.productModel.productDescription),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Material(
                            child: Container(
                              width: Get.width / 2.5,
                              height: Get.height / 15,
                              decoration: BoxDecoration(
                                color: AppConstants.appSecondaryColour,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextButton.icon(
                                icon: Image.asset(
                                  'assets/images/add-to-cart.png',
                                  height: 30,
                                  width: 30,
                                ),
                                onPressed: () {
                                  // Get.to(() => SigninScreen());
                                },
                                label: Text(
                                  "Add to cart",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppConstants.appTextColour,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: Get.width/20,),
                          Material(
                        child: Container(
                          width: Get.width / 2.5,
                          height: Get.height / 15,
                          decoration: BoxDecoration(
                            color: AppConstants.appSecondaryColour,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton.icon(
                            icon: Image.asset(
                              'assets/images/whatsapp.png',
                              height: 26,
                              width: 26,
                            ),
                            onPressed: () {
                              // Get.to(() => SigninScreen());
                            },
                            label: Text(
                              "WhatsApp",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.appTextColour
                              ),
                            ),
                          ),
                        ),
                      ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
