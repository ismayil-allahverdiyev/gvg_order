import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/constants/endpoints.dart';
import 'package:gvg_order/src/data/models/lists/lists_model.dart';
import 'package:gvg_order/src/data/models/outlet_list/outlet_list_model.dart';
import '../../data/repository/repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OutletsController extends GetxController
    with GetTickerProviderStateMixin {
  final Repository repository;
  OutletsController({required this.repository});

  var outlistList = <OutLet>[].obs;
  var listsList = <ListModel>[].obs;

  var selectedOutletId = Rxn<String>();
  var selectedOutletName = Rxn<String>();
  var selectedListId = Rxn<String>();

  var searchController = TextEditingController();

  TabController? tabController;

  @override
  void onInit() async {
    super.onInit();

    tabController = TabController(
      length: 2,
      vsync: this,
    );
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

  getLists() async {
    var res = listsModelFromJson(
      await repository.postData(
        endpoint: EndPoint.get_productlists_by_outlet_type,
        base: EndPoint.base_url_product,
        query: {
          "outletId": selectedOutletId.value,
          "term": searchController.text,
        },
      ),
    );

    if (!res.status) {
      repository.showMessage(
          title: AppLocalizations.of(Get.context!)!.error,
          message: res.message);
    } else {
      listsList.value = res.data;
    }
  }
}
