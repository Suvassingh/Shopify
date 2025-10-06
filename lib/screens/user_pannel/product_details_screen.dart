// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shopify/controllers/rating_controller.dart';
import 'package:shopify/models/cart_model.dart';
import 'package:shopify/models/product_model.dart';
import 'package:shopify/models/review_model.dart';
import 'package:shopify/screens/user_pannel/cart_screen.dart';
import 'package:shopify/utils/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ProductDetailsScreen extends StatefulWidget {
  ProductModel productModel;
  ProductDetailsScreen({super.key, required this.productModel});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  
  @override
  
  Widget build(BuildContext context) {
    CalculateProductRatingController calculateProductRatingController = Get.put(
      CalculateProductRatingController(widget.productModel.productId),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.productModel.productName,
          style: TextStyle(
            color: AppConstants.appTextColour,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppConstants.appTextColour),

        backgroundColor: AppConstants.appMainColour,
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => CartScreen()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_cart),
            ),
          )
        ],
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
                                  style: TextStyle(fontSize: 16,),
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
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: RatingBar.builder(
                            glow: false,
                            ignoreGestures: true,
                            initialRating: double.parse(
                              calculateProductRatingController.averageRating
                                  .toString(),
                            ),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 25,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) =>
                                Icon(Icons.star, color: Colors.amber),
                            onRatingUpdate: (value) {},
                          ),
                        ),
                        Text(
                          calculateProductRatingController.averageRating
                              .toString(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            widget.productModel.isSale == true &&
                                    widget.productModel.salePrice != ""
                                ? Text("Rs : " + widget.productModel.salePrice,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  )
                                : Text("Rs : " + widget.productModel.fullPrice,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(widget.productModel.productDescription,
                          style: TextStyle(
                            fontSize: 16,
                            
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,

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
                                onPressed: () async {
                                  checkProductExistance(uId: user!.uid);
                                  Get.snackbar(
                                    "Added to cart",
                                    'Product added to cart successfully',
                                    snackPosition: SnackPosition.TOP,
                                    colorText: AppConstants.appTextColour,
                                    backgroundColor:
                                        AppConstants.appSecondaryColour,
                                  );
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
                          SizedBox(width: Get.width / 20),
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
                                  sendMessangeOnwhatsapp(
                                    productModel:widget.productModel,
                                  );
                                },
                                label: Text(
                                  "WhatsApp",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppConstants.appTextColour,
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
            // review
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('products')
                  .doc(widget.productModel.productId)
                  .collection('reviews')
                  .get(),
              builder:
                  (
                    BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot,
                  ) {
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
                      return Center(child: Text("No reviews found!"));
                    }

                    if (snapshot.data != null) {
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs[index];
                          ReviewModel reviewModel = ReviewModel(
                            customerName: data['customerName'],
                            customerPhone: data['customerPhone'],
                            customerDeviceToken: data['customerDeviceToken'],
                            customerId: data['customerId'],
                            feedback: data['feedback'],
                            rating: data['rating'],
                            createdAt: data['createdAt'],
                          );
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(reviewModel.customerName[0]),
                              ),
                              title: Text(reviewModel.customerName),
                              subtitle: Text(reviewModel.feedback),
                              trailing: Text(reviewModel.rating),
                            ),
                          );
                        },
                      );
                    }

                    return Container();
                  },
            ),          ],
        ),
      ),
    );
  }

static Future<void> sendMessangeOnwhatsapp({required ProductModel productModel})async{
  final number = "+9779811769701";
  final message = "Hello from suvas \n i want to know about the product \n ${productModel.productName} ${productModel.productId} ";


  final url = 'https://wa.me/$number?text=${Uri.encodeComponent(message)}';

if(await canLaunch(url)){
  await launch(url);
}
else{
  throw'Could not launch $url';
}

}


  // Check product exist or not
  Future<void> checkProductExistance({
    required String uId,
    int quantityIncrement = 1,
  }) async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('cart')
        .doc(uId)
        .collection('cartOrders')
        .doc(widget.productModel.productId.toString());
    DocumentSnapshot snapshot = await documentReference.get();
    if (snapshot.exists) {
      int currentQuantity = snapshot['productQuantity'];
      int updatedQuantity = currentQuantity + quantityIncrement;
      double totalPrice =
          double.parse(
            widget.productModel.isSale
                ? widget.productModel.salePrice
                : widget.productModel.fullPrice,
          ) *
          updatedQuantity;
      await documentReference.update({
        'productQuantity': updatedQuantity,
        'productTotalPrice': totalPrice,
      });
      print("Product exist");
    } else {
      await FirebaseFirestore.instance.collection('cart').doc(uId).set({
        'uId': uId,
        'createdAt': DateTime.now(),
      });
      CartModel cartModel = CartModel(
        productId: widget.productModel.productId,
        categoryId: widget.productModel.categoryId,
        productName: widget.productModel.productName,
        categoryName: widget.productModel.categoryName,
        salePrice: widget.productModel.salePrice,
        fullPrice: widget.productModel.fullPrice,
        productImages: widget.productModel.productImages,
        deliveryTime: widget.productModel.deliveryTime,
        isSale: widget.productModel.isSale,
        productDescription: widget.productModel.productDescription,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        productQuantity: 1,
        productTotalPrice: double.parse(
          widget.productModel.isSale
              ? widget.productModel.salePrice
              : widget.productModel.fullPrice,
        ),
      );
      await documentReference.set(cartModel.toMap());
      print("Product added to cart");
    }                                  
  }
}
