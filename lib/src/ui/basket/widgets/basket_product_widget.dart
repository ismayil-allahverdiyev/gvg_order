import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../shared/widgets/custom_progress_indicator_widget.dart';
import '../../theme/app_colors.dart';
import 'background_widget.dart';

class BasketProductWidget extends StatelessWidget {
  final int index;
  const BasketProductWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return Future.value(true);
      },
      background: const BasketBackgroundWidget(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 12,
            ),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(
                  Routes.PRODUCT,
                  arguments: {
                    'productId': index,
                    'selectedCount': 1,
                    'availableProductCount': 30,
                  },
                );
              },
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        "https://media.istockphoto.com/id/458464735/tr/foto%C4%9Fraf/coke.jpg?s=2048x2048&w=is&k=20&c=DpnH4v1YRs4l1rmzu-xFi3wRjK44FUTYQBD8FJTwHx0=",
                    imageBuilder: (context, imageProvider) => Container(
                      width: Get.width * 0.2,
                      height: Get.width * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: lightGreyColor,
                        ),
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
                  const SizedBox(
                    width: 12,
                  ),
                  SizedBox(
                    width: Get.width * 0.4,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Coca cola original taste 1.5L",
                          maxLines: 2,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "20\$",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: Get.width * 0.24,
                    height: Get.width * 0.08,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.add,
                            color: primaryColor,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: primaryColor.withOpacity(0.1),
                            child: const Center(
                              child: Text(
                                "1",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.remove,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          index < 4
              ? const Divider(
                  endIndent: 12,
                  indent: 12,
                )
              : const SizedBox()
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
      width: Get.width * 0.2,
      height: Get.width * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: lightGreyColor,
        ),
        color: lightGreyColor,
      ),
      child: const CustomCircularProgressIndicator(),
    );
  }
}
