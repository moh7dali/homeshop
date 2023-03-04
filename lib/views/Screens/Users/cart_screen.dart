import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/utils/assets_constant.dart';
import 'package:homeShop/utils/constants.dart';
import 'package:homeShop/utils/theme/app_theme.dart';
import 'package:homeShop/viewmodel/cart_viewmodel.dart';
import 'package:homeShop/views/Widgets/cart_item_widget.dart';
import 'package:homeShop/views/Widgets/no_item_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(
      init: CartViewModel(),
      builder: (controller) {
        return controller.isLoad
            ? const Scaffold(body: Center(child: CircularProgressIndicator()))
            : Scaffold(
                appBar: AppBar(
                  iconTheme: const IconThemeData(color: Colors.white),
                  title: Text(
                    "cart".tr,
                    style: AppTheme.lightStyle(color: Colors.white, size: 17),
                  ),
                  backgroundColor: containerBackgroun,
                ),
                body: controller.cartData.isEmpty
                    ? NoItemWidget(
                        imgUrl: AssetsConstant.logo2,
                        subTitle: "addCrt".tr,
                        title: "emptyCart".tr,
                        imgSize: Get.width * .25,
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () => FocusScope.of(context).unfocus(),
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "cartItems".tr,
                                          style: AppTheme.boldStyle(
                                              color: Colors.black, size: 17),
                                        ),
                                      ),
                                      ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: controller.cartData.length,
                                        itemBuilder: (context, index) {
                                          return CartItemWidget(
                                            id: controller
                                                .cartData[index].productId,
                                            imgUrl: controller
                                                .cartData[index].productImgUrl,
                                            itemPrice: controller
                                                .cartData[index].oneItemPrice,
                                            totalPrice: controller
                                                .cartData[index].productPrice,
                                            offerPrice: controller
                                                .cartData[index]
                                                .oneItemOfferPrice,
                                            totalOfferPrice: controller
                                                .cartData[index]
                                                .productOfferPrice,
                                            prodTitle: controller
                                                .cartData[index].productName,
                                            prodQuantity: controller
                                                .cartData[index].quantity,
                                          );
                                        },
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(children: [
                                            Container(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "specialInstructions".tr,
                                                style: AppTheme.boldStyle(
                                                    color: Colors.black,
                                                    size: 18),
                                              ),
                                            ),
                                            TextField(
                                              onSubmitted: (value) {},
                                              controller: controller
                                                  .instructionsController,
                                              decoration: InputDecoration(
                                                hintText:
                                                    "specialInstructions".tr,
                                              ),
                                            )
                                          ]),
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "subTotal".tr,
                                                    style: AppTheme.lightStyle(
                                                        color: Colors.black,
                                                        size: 18),
                                                  ),
                                                  Text(
                                                    "${controller.constTotal!.toStringAsFixed(2)} ${"JD".tr}"
                                                        .tr,
                                                    style: AppTheme.lightStyle(
                                                        color: Colors.black,
                                                        size: 17),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "total".tr,
                                                        style:
                                                            AppTheme.lightStyle(
                                                                color: Colors
                                                                    .black,
                                                                size: 18),
                                                      ),
                                                      Text(
                                                        "${controller.subTotalLabel!.toStringAsFixed(2)} ${"JD".tr}",
                                                        style:
                                                            AppTheme.lightStyle(
                                                                color: Colors
                                                                    .black,
                                                                size: 18),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Divider(
                                                height: 20,
                                                thickness: 2,
                                                color: Colors.grey,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "finalAmount".tr,
                                                    style: AppTheme.boldStyle(
                                                        color: Colors.black,
                                                        size: 20),
                                                  ),
                                                  Text(
                                                    "${controller.finalAmount!.toStringAsFixed(2)} ${"JD".tr}",
                                                    style: AppTheme.boldStyle(
                                                        color:
                                                            containerBackgroun,
                                                        size: 20),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.deleteCartItems();
                                        // Helper().actionDialog(
                                        //     confirm: () {
                                        //       controller.deleteCartItems();
                                        //       Get.back();
                                        //     },
                                        //     cancel: () => Get.back(),
                                        //     title: "emptyCart".tr,
                                        //     body: "deleteConfirm".tr);
                                      },
                                      child: Container(
                                        width: Get.width * .175,
                                        height: Get.height * .07,
                                        decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle),
                                        child: const Icon(
                                          Icons.delete_forever,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          controller.addOrder();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: Size(
                                              Get.width * .7, Get.height * .07),
                                          backgroundColor: iconColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(200),
                                          ),
                                        ),
                                        child: Text(
                                          "OrderNow".tr,
                                          style: AppTheme.boldStyle(
                                              color: Colors.white, size: 20),
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(height: Get.height * .02)
                            ],
                          ),
                        ),
                      ));
      },
    );
  }
}