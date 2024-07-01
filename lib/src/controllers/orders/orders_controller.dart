import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/controllers/local_storage/local_storage_controller.dart';
import 'package:gvg_order/src/data/models/cards/cards_model.dart';
import '../../constants/endpoints.dart';
import '../../data/models/outlet_list/outlet_list_model.dart';
import '../../data/repository/repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrdersController extends GetxController {
  final Repository repository;

  OrdersController({required this.repository});

  LocalStorageController localStorageController = Get.find();

  var isLoading = false.obs;

  var cardsList = <CardModel>[].obs;
  var outlistList = <OutLet>[].obs;

  var selectedOutlet = Rxn<OutLet>();

  var selectedStartDate = Rxn<DateTime>();
  var selectedEndDate = Rxn<DateTime>();

  var searchController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();

    await cards();
    await getOutletList();
  }

  getOutletList() async {
    var res = outletListModelFromJson(
      await repository.postData(
        endpoint: EndPoint.get_outlet_list_gvg,
        base: EndPoint.base_url_product,
      ),
    );

    if (!res.status) {
      repository.showMessage(
          title: AppLocalizations.of(Get.context!)!.error,
          message: res.message);
    } else {
      outlistList.value = res.data;
    }
  }

  cards() async {
    try {
      isLoading.value = true;

      var res = cardsModelFromJson(
        await repository.postData(
          base: EndPoint.base_url_order,
          endpoint: EndPoint.cards,
          query: {
            "pageNumber": 1,
            "pageSize": 15,
          },
          object: {
            "outletId": selectedOutlet.value?.id,
            "searchText": searchController.text,
            "isPayment": null,
            "startDate": selectedStartDate.value == null
                ? null
                : ("${selectedStartDate.value!.toIso8601String()}Z"),
            "endDate": selectedEndDate.value == null
                ? null
                : ("${selectedEndDate.value!.toIso8601String()}Z"),
          },
        ),
      );

      isLoading.value = false;

      if (res.code == 200) {
        cardsList.assignAll(res.data);
      } else {
        repository.showMessage(
          title: AppLocalizations.of(Get.context!)!.error,
          message: res.message,
        );
      }
    } catch (e) {
      isLoading.value = false;
    }
  }
}
