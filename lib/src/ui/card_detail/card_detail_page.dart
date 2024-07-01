import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:gvg_order/src/controllers/card_detail/card_detail_controller.dart';
import 'package:gvg_order/src/ui/shared/widgets/custom_app_bar_widget.dart';
import 'package:gvg_order/src/ui/theme/app_colors.dart';

import 'widgets/card_detail_product_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardDetailPage extends GetView<CardDetailController> {
  const CardDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: whiteColor,
          appBar: CustomAppBar(
            title: AppLocalizations.of(context)!.carddetail,
            isBasketVisible: false,
          ),
          body: Obx(
            () {
              return ListView.builder(
                itemCount: controller.cardDetail.length,
                itemBuilder: (context, index) => CardDetailProductWidget(
                  product: controller.cardDetail[index],
                  index: index,
                  isLast: index == controller.cardDetail.length - 1,
                ),
              );
            },
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
