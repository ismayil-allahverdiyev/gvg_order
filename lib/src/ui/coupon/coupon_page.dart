import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import '../shared/widgets/custom_progress_indicator_widget.dart';
import '../theme/app_colors.dart';

class CouponPage extends StatelessWidget {
  const CouponPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        surfaceTintColor: whiteColor,
        shadowColor: Colors.black,
        elevation: 1,
        title: const Text(
          'Coupons / Campaigns',
          style: TextStyle(
            color: lightTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.xmark,
            color: lightTextColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(
                  color: lightGreyColor,
                ),
              ),
              leading: CachedNetworkImage(
                imageUrl:
                    "https://media.istockphoto.com/id/458464735/tr/foto%C4%9Fraf/coke.jpg?s=2048x2048&w=is&k=20&c=DpnH4v1YRs4l1rmzu-xFi3wRjK44FUTYQBD8FJTwHx0=",
                imageBuilder: (context, imageProvider) => Container(
                  width: Get.width * 0.1,
                  height: Get.width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                placeholder: (context, url) => const PlaceHolderWidget(),
                errorWidget: (context, url, error) => const PlaceHolderWidget(),
              ),
              title: Text(
                'Coupon $index',
                style: const TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Description for something that would be in 2 lines $index',
                maxLines: 2,
                style: const TextStyle(
                  color: lightTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    child: const Text(
                      'Apply',
                      style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
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
      width: Get.width * 0.1,
      height: Get.width * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: lightGreyColor,
      ),
      child: const CustomCircularProgressIndicator(),
    );
  }
}
