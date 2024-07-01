import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/data/models/order_list/order_list_model.dart';
import '../../../constants/assets.dart';
import '../../../controllers/basket/basket_controller.dart';
import '../../../data/models/card_detail/card_detail_model.dart';
import '../../../routes/app_routes.dart';
import '../../shared/widgets/custom_progress_indicator_widget.dart';
import '../../theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardDetailProductWidget extends StatelessWidget {
  final CardDetail product;
  final int index;
  final bool isLast;
  const CardDetailProductWidget({
    super.key,
    required this.product,
    required this.isLast,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 12,
          ),
          child: Row(
            children: [
              Container(
                width: Get.width * 0.2,
                height: Get.width * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: lightGreyColor,
                  ),
                  image: product.imageFile == null ||
                          product.imageFile!.image == null
                      ? const DecorationImage(
                          image: AssetImage(
                            Assets.image_placeholder,
                          ),
                          scale: 5,
                        )
                      : DecorationImage(
                          image: product.imageFile!.image!.image,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListView.builder(
                      itemCount: product.name.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Text(
                          product.name[index],
                          style: const TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    Text(
                      product.price.toString() + " tl",
                      style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        !isLast
            ? const Divider(
                endIndent: 12,
                indent: 12,
              )
            : const SizedBox()
      ],
    );
  }
}
