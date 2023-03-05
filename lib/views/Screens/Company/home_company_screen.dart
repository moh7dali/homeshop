import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeShop/utils/assets_constant.dart';
import 'package:homeShop/utils/constants.dart';
import 'package:homeShop/viewmodel/home_company_viewmodel.dart';
import 'package:homeShop/views/Screens/Company/add_product_screen.dart';
import 'package:homeShop/views/Widgets/drawer.dart';
import 'package:homeShop/views/Widgets/no_item_widget.dart';
import 'package:homeShop/views/Widgets/product_card.dart';

class HomeCompany extends StatelessWidget {
  const HomeCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeCompanyViewModel>(
      init: HomeCompanyViewModel(),
      builder: (controller) {
        return Scaffold(
            drawer: const Drawerwidget(),
            appBar: AppBar(
              iconTheme: IconThemeData(color: containerBackgroun),
              backgroundColor: Colors.white,
              elevation: 0,
              title: Image.asset(AssetsConstant.logo2, width: Get.width * .2),
              centerTitle: true,
              actions: [],
            ),
            body: Column(
              children: [
                controller.isLoad
                    ? const Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: RefreshIndicator(
                            onRefresh: () async {
                              return await controller.init();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  controller.data.length == 0
                                      ? NoItemWidget(
                                          title: "no proudects",
                                          subTitle: "",
                                          imgUrl: AssetsConstant.logo2,
                                          imgSize: 100,
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: controller.data.length,
                                          itemBuilder: (context, index) {
                                            return ProductCardWidget(
                                              isShop: true,
                                              productID: controller.data[index]
                                                  ['productID'],
                                              productName: controller
                                                  .data[index]['productName'],
                                              productImgUrl: controller
                                                  .data[index]['productImgUrl'],
                                              productPrice: controller
                                                  .data[index]['productPrice'],
                                              edit: () {
                                                print("edit clicked");
                                                Get.to(AddProductScreen(
                                                  productId: controller
                                                      .data[index]['productID'],
                                                ));
                                              },
                                              delete: () async {
                                                print("delete clicked");
                                                await controller.deleteProduct(
                                                    controller.data[index]
                                                        ['productID']);
                                              },
                                            );
                                          },
                                        ),
                                ],
                              ),
                            )),
                      ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: containerBackgroun,
              onPressed: () {},
              child: IconButton(
                onPressed: () {
                  Get.to(AddProductScreen(
                    productId: null,
                  ));
                },
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ),
                color: Colors.white,
              ),
            ));
      },
    );
  }
}
