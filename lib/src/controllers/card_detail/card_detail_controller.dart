import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/data/models/card_detail/card_detail_model.dart';
import 'package:gvg_order/src/data/models/cards/cards_model.dart';
import '../../constants/endpoints.dart';
import '../../data/models/image_file/image_file_model.dart';
import '../../data/models/outlet_list/outlet_list_model.dart';
import '../../data/repository/repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardDetailController extends GetxController {
  final Repository repository;

  CardDetailController({required this.repository});

  var isLoading = false.obs;

  var cardId = "";

  var cardDetail = <CardDetail>[].obs;

  @override
  void onInit() async {
    super.onInit();

    cardId = Get.arguments["cardId"];

    await getCardDetail();
  }

  getCardDetail() async {
    try {
      isLoading.value = true;

      var res = cardDetailModelFromJson(
        await repository.getData(
          endpoint: EndPoint.cardDetail,
          base: EndPoint.base_url_order,
          query: {
            "cardId": cardId,
          },
        ),
      );

      isLoading.value = false;

      if (res.code == 200) {
        cardDetail.value = res.data;

        for (var product in cardDetail) {
          product.imageFile = await getFile(product: product);
          cardDetail.refresh();
        }
      }
    } catch (e) {
      isLoading.value = false;
      repository.showMessage(
        title: AppLocalizations.of(Get.context!)!.error,
        message: e.toString(),
      );
    }
  }

  getFile({required CardDetail product}) async {
    var res = imageFileModelFromJson(
      await repository.getData(
          endpoint: EndPoint.getFile,
          base: EndPoint.base_url_product,
          query: {
            "folder": product.isCampaign ? "campaign" : "product",
            "fileName":
                product.isCampaign ? product.campaignId : product.produuctId,
          }),
    );

    if (res.code == 200) {
      return res.data;
    } else {
      repository.showMessage(
        title: AppLocalizations.of(Get.context!)!.error,
        message: res.message,
      );
    }
  }
}
