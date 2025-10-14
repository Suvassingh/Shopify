import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:shopify/controllers/cart_price_controller.dart';
import 'package:shopify/controllers/get_customer_device_token_controller.dart';
import 'package:shopify/models/cart_model.dart';
import 'package:shopify/services/get_service_key.dart';
import 'package:shopify/services/place_order_service.dart';
import 'package:shopify/utils/app_constants.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final CartPriceController cartPriceController = Get.put(
    CartPriceController(),
  );
  User? user = FirebaseAuth.instance.currentUser;
TextEditingController nameController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController addressController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Checkout Screen",
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
            .collection('cart')
            .doc(user!.uid)
            .collection('cartOrders')
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
                      productTotalPrice: double.parse(productData['productTotalPrice'].toString()),
                    );
                    // calculate Price
                    cartPriceController.fetchProductsPrice();
                    return SwipeActionCell(
                      key: ObjectKey(cartModel.productId),
                      trailingActions: [
                        SwipeAction(
                          forceAlignmentToBoundary: true,
                          performsFirstActionWithFullSwipe: true,
                          title: "Delete",
                          onTap: (CompletionHandler handler) async {
                            await FirebaseFirestore.instance
                                .collection('cart')
                                .doc(user!.uid)
                                .collection('cartOrders')
                                .doc(cartModel.productId)
                                .delete();
                            setState(() {});
                          },
                          color: Colors.red,
                        ),
                      ],
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppConstants.appMainColour,
                            backgroundImage: NetworkImage(
                              cartModel.productImages[0],
                            ),
                          ),
                          title: Text(cartModel.productName),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(cartModel.productTotalPrice.toString()),
                            ],
                          ),
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
            Obx(
              () =>
                  // ignore: prefer_interpolation_to_compose_strings
                  Text(
                    // ignore: prefer_interpolation_to_compose_strings
                    "Total Price Rs :" +
                        cartPriceController.totalPrice.value.toStringAsFixed(1),
                  ),
            ),
            SizedBox(width: Get.width / 7),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                child: Container(
                  width: Get.width / 2.5,
                  height: Get.height / 18,
                  decoration: BoxDecoration(
                    color: AppConstants.appSecondaryColour,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: ()async {
                      // Get.to(() => SigninScreen());
                      // showCustomBottomSheet();
                      GetServerKey getServerKey = GetServerKey();
                      String accessToken =await  getServerKey.getServerKeyToken();
                      print(accessToken );

                    },
                    child: Text(
                      "Confirm Order",
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

void showCustomBottomSheet() {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Container(
                  height: 55.0,
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Container(
                  height: 55.0,
                  child: TextFormField(
                    controller:  phoneController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Phone",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Container(
                  height: 55.0,
                  child: TextFormField(
                  controller: addressController,
                    decoration: InputDecoration(
                      labelText: "Address",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.appSecondaryColour,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                ),
                onPressed: () async{
                  if(nameController.text!=''&&phoneController.text !=''&&addressController.text !=''){
                    String name = nameController.text.trim();
                    String phone = phoneController.text.trim();
                    String address = addressController.text.trim();
                  String customerToken = await  getCustomerDeviceToken();
                  placeOrder(
                    // ignore: use_build_context_synchronously
                    context:context,
                    customerName:name,
                    customerPhone:phone,
                    customerAddress:address,
                    customerDeviceToken:customerToken,

                  );
                  


                  }else{
                    Get.snackbar(
                      "Error",
                      'Please fill all fields',
                      snackPosition: SnackPosition.TOP,
                      colorText: AppConstants.appTextColour,
                      backgroundColor: AppConstants.appSecondaryColour,
                    );
                  }
                },
                child: Text(
                  "Place order",
                  style: TextStyle(color: AppConstants.appTextColour),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      elevation: 6,
    );
  }



}


