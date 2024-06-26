import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/constants/endpoints.dart';
import 'package:gvg_order/src/data/models/order_list/order_list_model.dart';
import '../../data/models/parent_categories/parent_categories_model.dart';
import '../../data/models/sub_categories/sub_categories_model.dart';
import '../../data/repository/repository.dart';
import '../basket/basket_controller.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  final Repository repository;
  HomeController({required this.repository});

  var outletId = "";
  var outletName = "";
  var listId = "";

  var selectedTab = 0.obs;

  var openIndex = Rxn<String>();

  var orderList = <OrderList>[].obs;
  var parentCategories = <ParentCategory>[].obs;
  var subCategories = <SubCategory>[].obs;

  var selectedParentCategory = Rxn<ParentCategory>();
  var selectedSubCategory = Rxn<SubCategory>();

  var searchTextEditingController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    outletId = Get.arguments["outletId"];
    outletName = Get.arguments["outletName"];
    listId = Get.arguments["listId"];

    await getParentCategories();
    await getListOrders();
  }

  getListOrders() async {
    var response = orderListModelFromJson(
      await repository.getData(
        base: EndPoint.base_url_product,
        endpoint: EndPoint.get_list_orders,
        query: {
          "listId": "149e56b0-af99-4262-b4a8-78967c6b6bcc",
          "parentCategoryId": selectedParentCategory.value?.id ?? "",
          "subCategoryId": selectedSubCategory.value?.id ?? "",
          "pageNumber": 1,
          "pageSize": 15,
          "searchText": searchTextEditingController.text,
        },
      ),
    );

    if (response.code == 200) {
      orderList.value = response.data ?? [];

      var basketController = Get.find<BasketController>();

      orderList.forEach((element) {
        var index = basketController.basketList.indexWhere(
            (basketElement) => basketElement.productId == element.productId);
        if (index != -1) {
          element.selectedCount =
              basketController.basketList[index].selectedCount;
        }
      });

      orderList.refresh();
    } else {
      repository.showMessage(
        title: "Error",
        message: response.message,
      );
    }
  }

  getCampaigns() async {
    var response = orderListModelFromJson(
      await repository.getData(
        base: EndPoint.base_url_product,
        endpoint: EndPoint.getCampaigns,
        query: {
          "listId": listId,
        },
      ),
    );

    if (response.code == 200) {
      orderList.value = response.data ?? [];
      orderList.refresh();
    } else {
      repository.showMessage(
        title: "Error",
        message: response.message,
      );
    }
  }

  getParentCategories() async {
    parentCategories.clear();
    var response = parentCategoriesModelFromJson(
      await repository.getData(
        base: EndPoint.base_url_product,
        endpoint: EndPoint.get_parent_categories,
      ),
    );

    if (response.code == 200) {
      parentCategories.value = response.data;
      selectedParentCategory.value = response.data.first;
      await getSUbCategories();
    } else {
      repository.showMessage(
        title: "Error",
        message: response.message,
      );
    }
  }

  getSUbCategories() async {
    subCategories.clear();
    orderList.clear();
    var response = subCategoriesModelFromJson(
      await repository.getData(
        base: EndPoint.base_url_product,
        endpoint: EndPoint.get_sub_categories,
        query: {
          "parentCategoryId": selectedParentCategory.value!.id,
        },
      ),
    );

    if (response.code == 200) {
      subCategories.value = response.data;
      if (response.data.isNotEmpty) {
        selectedSubCategory.value = response.data.first;
      }
      await getListOrders();
    } else {
      repository.showMessage(
        title: "Error",
        message: response.message,
      );
    }
  }

  updateProductCount({required OrderList product, required bool isAdd}) async {
    var basketController = Get.find<BasketController>();
    var index = orderList
        .indexWhere((element) => element.productId == product.productId);
    if (isAdd) {
      orderList[index].selectedCount++;
    } else {
      orderList[index].selectedCount--;
    }
    basketController.editBasketList(orderList: orderList[index]);

    // orderList.value = orderList;
    // orderList.refresh();
    update(["orderList"]);
  }
}
