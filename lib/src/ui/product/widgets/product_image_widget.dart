import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/widgets/custom_progress_indicator_widget.dart';
import '../../theme/app_colors.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: productId.toString(),
      child: CachedNetworkImage(
        imageUrl:
            "https://media.istockphoto.com/id/458464735/tr/foto%C4%9Fraf/coke.jpg?s=2048x2048&w=is&k=20&c=DpnH4v1YRs4l1rmzu-xFi3wRjK44FUTYQBD8FJTwHx0=",
        imageBuilder: (context, imageProvider) => Stack(
          children: [
            Container(
              width: Get.width,
              height: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.favorite_outline_sharp),
                onPressed: () {},
              ),
            ),
          ],
        ),
        placeholder: (context, url) => const PlaceHolderWidget(),
        errorWidget: (context, url, error) => const PlaceHolderWidget(),
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
      width: Get.width,
      height: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: lightGreyColor,
      ),
      child: const CustomCircularProgressIndicator(),
    );
  }
}
