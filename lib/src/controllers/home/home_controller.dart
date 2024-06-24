import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/constants/endpoints.dart';
import 'package:gvg_order/src/data/models/order_list/order_list_model.dart';
import '../../data/models/parent_categories/parent_categories_model.dart';
import '../../data/models/sub_categories/sub_categories_model.dart';
import '../../data/repository/repository.dart';

class HomeController extends GetxController {
  final Repository repository;
  HomeController({required this.repository});

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

    await getParentCategories();
    await getListOrders();
  }

  getListOrders() async {
    var response = orderListModelFromJson(
      await repository.getData(
        base: EndPoint.base_url_product,
        endpoint: EndPoint.get_list_orders,
        query: {
          "listId": "ab957e56-03ac-4eb4-a08b-6d11be803089",
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
    } else {
      repository.showMessage(
        title: "Error",
        message: response.message,
      );
    }
  }

  getParentCategories() async {
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
}
