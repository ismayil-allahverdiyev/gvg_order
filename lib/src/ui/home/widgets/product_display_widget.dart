import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/routes/app_routes.dart';

import '../../../controllers/home/home_controller.dart';
import '../../shared/widgets/custom_progress_indicator_widget.dart';
import '../../theme/app_colors.dart';

class ProductDisplayWidget extends GetWidget<HomeController> {
  final int index;
  const ProductDisplayWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        Routes.PRODUCT,
        arguments: {
          'productId': index,
          'selectedCount': 0,
          'availableProductCount': 30,
        },
      ),
      child: Column(
        children: [
          SizedBox(
            height: Get.width * 0.08 / 2,
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Hero(
                tag: index.toString(),
                child: CachedNetworkImage(
                  imageUrl:
                      "https://media.istockphoto.com/id/458464735/tr/foto%C4%9Fraf/coke.jpg?s=2048x2048&w=is&k=20&c=DpnH4v1YRs4l1rmzu-xFi3wRjK44FUTYQBD8FJTwHx0=",
                  imageBuilder: (context, imageProvider) => Container(
                    width: Get.width / 4,
                    height: Get.width / 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => const PlaceHolderWidget(),
                  errorWidget: (context, url, error) =>
                      const PlaceHolderWidget(),
                ),
              ),
              Positioned(
                top: -Get.width * 0.05 / 2,
                right: -Get.width * 0.05 / 2,
                child: GestureDetector(
                  onTap: () {
                    print(index);
                    if (controller.openIndex.value == index) {
                      controller.openIndex.value = null;
                    } else {
                      controller.openIndex.value = index;
                    }
                  },
                  child: Obx(
                    () {
                      return Container(
                        width: Get.width * 0.08,
                        height: controller.openIndex.value == index
                            ? Get.width * 0.24 + 2
                            : Get.width * 0.08 + 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: primaryColor,
                          ),
                          color: whiteColor,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.width * 0.08,
                              width: Get.width * 0.08,
                              child: const Center(
                                child: Icon(
                                  Icons.add,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              reverseDuration:
                                  const Duration(milliseconds: 300),
                              child: Obx(
                                () {
                                  return controller.openIndex.value == index
                                      ? SizedBox(
                                          height: controller.openIndex.value ==
                                                  index
                                              ? Get.width * 0.16
                                              : 0,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: Get.width * 0.08,
                                                width: Get.width * 0.08,
                                                color: primaryColor
                                                    .withOpacity(0.1),
                                                child: Center(
                                                  child: Text(
                                                    index.toString(),
                                                    style: const TextStyle(
                                                      color: primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: Get.width * 0.08,
                                                width: Get.width * 0.08,
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : const SizedBox();
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: Get.width / 6 * 0.25,
              right: Get.width / 6 * 0.1,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Product describti $index',
                style: const TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: Get.width / 6 * 0.25,
              right: Get.width / 6 * 0.1,
            ),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '\$10',
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceHolderWidget extends StatelessWidget {
  const PlaceHolderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 4,
      height: Get.width / 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: lightGreyColor.withOpacity(0.2),
        border: Border.all(
          color: lightGreyColor,
        ),
      ),
      child: const CustomCircularProgressIndicator(),
    );
  }
}
