import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/controllers/product/product_controller.dart';
import 'package:gvg_order/src/ui/shared/widgets/custom_app_bar_widget.dart';
import 'package:gvg_order/src/ui/theme/app_colors.dart';
import 'widgets/product_image_widget.dart';

class ProductPage extends GetView<ProductController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: const CustomAppBar(
        title: "Product Page",
        isBasketVisible: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImageWidget(productId: controller.productId),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
              child: ListView(
                children: const [
                  Text(
                    "Product Brand",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Coca Cola Original Taste",
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Product Description is here and it is a long text that will be displayed in the product page",
                    style: TextStyle(
                      color: lightTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "${controller.availableProductCount} products available",
              style: TextStyle(
                color: lightGreyColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width / 4,
                  child: const Center(
                    child: Text(
                      "20\$",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                    child: InkWell(
                      onTap: () {
                        if (controller.selectedCount.value == 1) {
                          controller.selectedCount.value = 0;
                        } else {
                          controller.selectedCount.value = 1;
                        }
                      },
                      child: Container(
                        height: Get.width * 0.12,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Obx(
                          () {
                            return controller.selectedCount.value > 0
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.removeFromBasket();
                                          },
                                          child: Container(
                                            color:
                                                Colors.white.withOpacity(0.3),
                                            child: const Center(
                                              child: Icon(
                                                Icons.remove,
                                                color: whiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            color: primaryColor,
                                            child: Center(
                                              child: Text(
                                                controller.selectedCount.value
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.addToBasket();
                                          },
                                          child: Container(
                                            color:
                                                Colors.white.withOpacity(0.3),
                                            child: const Center(
                                              child: Icon(
                                                Icons.add,
                                                color: whiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const Center(
                                    child: Text(
                                      "Add to Basket",
                                      style: TextStyle(
                                        color: whiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
