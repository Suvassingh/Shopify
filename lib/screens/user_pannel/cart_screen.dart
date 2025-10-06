import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:shopify/controllers/cart_price_controller.dart';
import 'package:shopify/models/cart_model.dart';
import 'package:shopify/screens/user_pannel/checkout_screen.dart';
import 'package:shopify/utils/app_constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartPriceController cartPriceController = Get.put(
    CartPriceController(),
  );
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
                      productTotalPrice: productData['productTotalPrice'],
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
                              SizedBox(width: Get.width / 20),

                              GestureDetector(
                                onTap: () async {
                                  if (cartModel.productQuantity > 1) {
                                    FirebaseFirestore.instance
                                        .collection('cart')
                                        .doc(user!.uid)
                                        .collection('cartOrders')
                                        .doc(cartModel.productId)
                                        .update({
                                          'productQuantity':
                                              cartModel.productQuantity - 1,
                                          'productTotalPrice':
                                              (double.parse(
                                                cartModel.isSale
                                                    ? cartModel.salePrice
                                                    : cartModel.fullPrice,
                                              ) *
                                              (cartModel.productQuantity - 1)),
                                        });
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: AppConstants.appMainColour,
                                  child: Text("-"),
                                ),
                              ),
                              SizedBox(width: Get.width / 35),
                              CircleAvatar(
                                child: Text(
                                  cartModel.productQuantity.toString(),
                                ),
                              ),
                              SizedBox(width: Get.width / 35),

                              GestureDetector(
                                onTap: () async {
                                  if (cartModel.productQuantity > 0) {
                                    FirebaseFirestore.instance
                                        .collection('cart')
                                        .doc(user!.uid)
                                        .collection('cartOrders')
                                        .doc(cartModel.productId)
                                        .update({
                                          'productQuantity':
                                              cartModel.productQuantity + 1,
                                          'productTotalPrice':
                                              double.parse(
                                                cartModel.isSale
                                                    ? cartModel.salePrice
                                                    : cartModel.fullPrice,
                                              ) +
                                              double.parse(
                                                    cartModel.isSale
                                                        ? cartModel.salePrice
                                                        : cartModel.fullPrice,
                                                  ) *
                                                  (cartModel.productQuantity),
                                        });
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: AppConstants.appMainColour,
                                  child: Text("+"),
                                ),
                              ),
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
                  child: TextButton.icon(
                    icon: Image.asset(
                      'assets/images/buy-button.png',
                      height: 34,
                      width: 34,
                    ),
                    onPressed: () {
                       Get.to(() => CheckoutScreen());
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










// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
// import 'package:get/get.dart';
// import 'package:shopify/controllers/cart_price_controller.dart';
// import 'package:shopify/models/cart_model.dart';
// import 'package:shopify/utils/app_constants.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   final CartPriceController cartPriceController = Get.put(
//     CartPriceController(),
//   );
//   User? user = FirebaseAuth.instance.currentUser;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "My Cart",
//           style: TextStyle(
//             color: AppConstants.appTextColour,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//         iconTheme: IconThemeData(color: AppConstants.appTextColour),
//         centerTitle: true,
//         backgroundColor: AppConstants.appMainColour,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           // Header with item count
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: Row(
//               children: [
//                 Text(
//                   "Items in Cart",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('cart')
//                   .doc(user!.uid)
//                   .collection('cartOrders')
//                   .snapshots(),
//               builder:
//                   (
//                     BuildContext context,
//                     AsyncSnapshot<QuerySnapshot> snapshot,
//                   ) {
//                     if (snapshot.hasError) {
//                       return _buildErrorWidget();
//                     }
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return _buildLoadingWidget();
//                     }
//                     if (snapshot.data!.docs.isEmpty) {
//                       return _buildEmptyCartWidget();
//                     }
//                     if (snapshot.data != null) {
//                       return _buildCartItems(snapshot);
//                     }
//                     return Container();
//                   },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: _buildBottomAppBar(),
//     );
//   }

//   Widget _buildErrorWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
//           SizedBox(height: 16),
//           Text(
//             "Something went wrong",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//               color: Colors.grey[600],
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             "Please try again later",
//             style: TextStyle(color: Colors.grey[500]),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLoadingWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CupertinoActivityIndicator(radius: 16),
//           SizedBox(height: 16),
//           Text(
//             "Loading your cart...",
//             style: TextStyle(color: Colors.grey[600]),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyCartWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.shopping_cart_outlined,
//             size: 100,
//             color: Colors.grey[300],
//           ),
//           SizedBox(height: 24),
//           Text(
//             "Your cart is empty",
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w500,
//               color: Colors.grey[600],
//             ),
//           ),
//           SizedBox(height: 12),
//           Text(
//             "Add some items to get started",
//             style: TextStyle(color: Colors.grey[500]),
//           ),
//           SizedBox(height: 24),
//           ElevatedButton(
//             onPressed: () {
//               // Navigate to products screen
//               Get.back();
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppConstants.appMainColour,
//               padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(24),
//               ),
//             ),
//             child: Text(
//               "Continue Shopping",
//               style: TextStyle(
//                 color: AppConstants.appTextColour,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCartItems(AsyncSnapshot<QuerySnapshot> snapshot) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       child: ListView.builder(
//         itemCount: snapshot.data!.docs.length,
//         shrinkWrap: true,
//         physics: BouncingScrollPhysics(),
//         itemBuilder: (context, index) {
//           final productData = snapshot.data!.docs[index];
//           CartModel cartModel = CartModel(
//             productId: productData['productId'],
//             categoryId: productData['categoryId'],
//             productName: productData['productName'],
//             categoryName: productData['categoryName'],
//             salePrice: productData['salePrice'],
//             fullPrice: productData['fullPrice'],
//             productImages: productData['productImages'],
//             deliveryTime: productData['deliveryTime'],
//             isSale: productData['isSale'],
//             productDescription: productData['productDescription'],
//             createdAt: productData['createdAt'],
//             updatedAt: productData['updatedAt'],
//             productQuantity: productData['productQuantity'],
//             productTotalPrice: productData['productTotalPrice'],
//           );

//           cartPriceController.fetchProductsPrice();

//           return _buildCartItemCard(cartModel);
//         },
//       ),
//     );
//   }

//   Widget _buildCartItemCard(CartModel cartModel) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: SwipeActionCell(
//         key: ObjectKey(cartModel.productId),
//         trailingActions: [
//           SwipeAction(
//             forceAlignmentToBoundary: true,
//             performsFirstActionWithFullSwipe: true,
//             title: "Delete",
//             onTap: (CompletionHandler handler) async {
//               await FirebaseFirestore.instance
//                   .collection('cart')
//                   .doc(user!.uid)
//                   .collection('cartOrders')
//                   .doc(cartModel.productId)
//                   .delete();
//               setState(() {});
//             },
//             color: Colors.red,
//           ),
//         ],
//         child: Card(
//           elevation: 2,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Container(
//             padding: EdgeInsets.all(12),
//             child: Row(
//               children: [
//                 // Product Image
//                 Container(
//                   width: 80,
//                   height: 80,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     image: DecorationImage(
//                       image: NetworkImage(cartModel.productImages[0]),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 12),

//                 // Product Details
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         cartModel.productName,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         cartModel.categoryName,
//                         style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                       ),
//                       SizedBox(height: 8),

//                       // Price and Quantity
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Rs ${cartModel.productTotalPrice.toStringAsFixed(2)}",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: AppConstants.appMainColour,
//                             ),
//                           ),

//                           // Quantity Controls
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.grey[100],
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Row(
//                               children: [
//                                 // Decrease Button
//                                 _buildQuantityButton(
//                                   icon: Icons.remove,
//                                   onTap: () => _updateQuantity(cartModel, -1),
//                                   isEnabled: cartModel.productQuantity > 1,
//                                 ),

//                                 // Quantity Display
//                                 Container(
//                                   padding: EdgeInsets.symmetric(
//                                     horizontal: 12,
//                                     vertical: 4,
//                                   ),
//                                   child: Text(
//                                     cartModel.productQuantity.toString(),
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                 ),

//                                 // Increase Button
//                                 _buildQuantityButton(
//                                   icon: Icons.add,
//                                   onTap: () => _updateQuantity(cartModel, 1),
//                                   isEnabled: true,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildQuantityButton({
//     required IconData icon,
//     required VoidCallback onTap,
//     required bool isEnabled,
//   }) {
//     return GestureDetector(
//       onTap: isEnabled ? onTap : null,
//       child: Container(
//         width: 30,
//         height: 30,
//         decoration: BoxDecoration(
//           color: isEnabled ? AppConstants.appMainColour : Colors.grey[300],
//           shape: BoxShape.circle,
//         ),
//         child: Icon(
//           icon,
//           size: 16,
//           color: isEnabled ? AppConstants.appTextColour : Colors.grey[500],
//         ),
//       ),
//     );
//   }

//   void _updateQuantity(CartModel cartModel, int change) {
//     int newQuantity = cartModel.productQuantity + change;
//     if (newQuantity < 1) return;

//     double unitPrice = double.parse(
//       cartModel.isSale ? cartModel.salePrice : cartModel.fullPrice,
//     );

//     FirebaseFirestore.instance
//         .collection('cart')
//         .doc(user!.uid)
//         .collection('cartOrders')
//         .doc(cartModel.productId)
//         .update({
//           'productQuantity': newQuantity,
//           'productTotalPrice': unitPrice * newQuantity,
//         });
//   }

//   Widget _buildBottomAppBar() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 8,
//             offset: Offset(0, -2),
//           ),
//         ],
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//       child: SafeArea(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // Total Price
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Total Price",
//                   style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                 ),
//                 SizedBox(height: 4),
//                 Obx(
//                   () => Text(
//                     "Rs ${cartPriceController.totalPrice.value.toStringAsFixed(2)}",
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: AppConstants.appMainColour,
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             // Checkout Button
//             Container(
//               width: Get.width / 2.2,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Navigate to checkout
//                   // Get.to(() => CheckoutScreen());
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppConstants.appSecondaryColour,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                   elevation: 2,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.shopping_bag_outlined,
//                       color: AppConstants.appTextColour,
//                       size: 20,
//                     ),
//                     SizedBox(width: 8),
//                     Text(
//                       "CHECKOUT",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: AppConstants.appTextColour,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
