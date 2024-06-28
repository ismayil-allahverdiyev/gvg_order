import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/data/cards/cards_model.dart';
import '../../constants/endpoints.dart';
import '../../data/models/outlet_list/outlet_list_model.dart';
import '../../data/repository/repository.dart';

class OrdersController extends GetxController {
  final Repository repository;

  OrdersController({required this.repository});

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
      repository.showMessage(title: "Error", message: res.message);
    } else {
      outlistList.value = res.data;
    }
  }

  cards() async {
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

    if (res.code == 200) {
      cardsList.assignAll(res.data);
    } else {
      repository.showMessage(
        title: "Error",
        message: res.message,
      );
    }
  }
}
