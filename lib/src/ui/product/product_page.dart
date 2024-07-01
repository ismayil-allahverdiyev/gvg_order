import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/constants/assets.dart';
import 'package:gvg_order/src/controllers/product/product_controller.dart';
import 'package:gvg_order/src/ui/shared/widgets/custom_app_bar_widget.dart';
import 'package:gvg_order/src/ui/theme/app_colors.dart';
import 'widgets/product_image_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductPage extends GetView<ProductController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: whiteColor,
          appBar: CustomAppBar(
            title: AppLocalizations.of(context)!.productpage,
            isBasketVisible: true,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImageWidget(productId: controller.productId),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: ListView(
                    children: [
                      Obx(
                        () {
                          return Text(
                            controller.productDetail.value?.brandName ?? "",
                            style: const TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          );
                        },
                      ),
                      Obx(
                        () {
                          return Text(
                            controller.productDetail.value?.productName ?? "",
                            style: const TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          );
                        },
                      ),
                      Obx(
                        () {
                          return Text(
                            controller.productDetail.value?.description1 ?? "",
                            style: const TextStyle(
                              color: lightTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          );
                        },
                      ),
                      Obx(
                        () {
                          if (controller.productDetail.value?.description2 !=
                              null) {
                            return Text(
                              controller.productDetail.value?.description2 ??
                                  "",
                              style: const TextStyle(
                                color: lightTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      Obx(
                        () {
                          if (controller.productDetail.value?.description3 !=
                              null) {
                            return Text(
                              controller.productDetail.value?.description3 ??
                                  "",
                              style: const TextStyle(
                                color: lightTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      Obx(
                        () {
                          if (controller.productDetail.value?.description4 !=
                              null) {
                            return Text(
                              controller.productDetail.value?.description4 ??
                                  "",
                              style: const TextStyle(
                                color: lightTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      Obx(
                        () {
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller
                                    .productDetail.value?.products?.length ??
                                0,
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 8,
                              );
                            },
                            itemBuilder: (context, index) {
                              return ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                    color: lightGreyColor,
                                    width: 1,
                                  ),
                                ),
                                title: Text(
                                  controller.productDetail.value
                                          ?.products?[index].productName ??
                                      "",
                                  style: const TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Text(
                                  controller.productDetail.value
                                          ?.products?[index].brandName ??
                                      "",
                                  style: const TextStyle(
                                    color: lightTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                leading: Obx(
                                  () {
                                    return Container(
                                      width: Get.width * 0.1,
                                      height: Get.width * 0.1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: controller
                                                    .productDetail
                                                    .value
                                                    ?.products?[index]
                                                    .imageFile
                                                    ?.image ==
                                                null
                                            ? const DecorationImage(
                                                image: AssetImage(
                                                  Assets.image_placeholder,
                                                ),
                                              )
                                            : DecorationImage(
                                                image: controller
                                                    .productDetail
                                                    .value!
                                                    .products![index]
                                                    .imageFile!
                                                    .image!
                                                    .image,
                                              ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
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
                      child: Center(
                        child: Column(
                          children: [
                            Obx(
                              () {
                                return Text(
                                  "${controller.productDetail.value?.listPrice ?? ""} tl",
                                  style: TextStyle(
                                    color: controller.productDetail.value
                                                ?.discountedListPrice ==
                                            controller
                                                .productDetail.value?.listPrice
                                        ? primaryColor
                                        : redColor,
                                    fontWeight: FontWeight.bold,
                                    decoration: controller.productDetail.value
                                                ?.discountedListPrice ==
                                            controller
                                                .productDetail.value?.listPrice
                                        ? TextDecoration.none
                                        : TextDecoration.lineThrough,
                                    decorationColor: primaryColor,
                                    fontSize: 16,
                                  ),
                                );
                              },
                            ),
                            Obx(
                              () {
                                return controller.productDetail.value
                                            ?.discountedListPrice !=
                                        controller
                                            .productDetail.value?.listPrice
                                    ? Text(
                                        "${controller.productDetail.value?.discountedListPrice ?? ""} tl",
                                        style: const TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      )
                                    : const SizedBox();
                              },
                            ),
                          ],
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
                                                color: Colors.white
                                                    .withOpacity(0.3),
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
                                                    controller
                                                        .selectedCount.value
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: whiteColor,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                color: Colors.white
                                                    .withOpacity(0.3),
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
                                    : Center(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .addtobasket,
                                          style: const TextStyle(
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
        ),
        Positioned(
          child: Obx(
            () {
              return controller.isLoading.value
                  ? Container(
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : const SizedBox();
            },
          ),
        )
      ],
    );
  }
}
