import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/constants/endpoints.dart';
import 'package:gvg_order/src/data/models/image_file/image_file_model.dart';
import 'package:gvg_order/src/data/models/order_list/order_list_model.dart';
import '../../data/models/parent_categories/parent_categories_model.dart';
import '../../data/models/sub_categories/sub_categories_model.dart';
import '../../data/repository/repository.dart';
import '../basket/basket_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  final Repository repository;
  HomeController({required this.repository});

  var scaffoldKey = GlobalKey<ScaffoldState>();

  var isLoading = false.obs;

  var outletId = "";
  var outletName = "";
  var listId = "";

  var selectedTab = 0.obs;

  var openIndex = Rxn<String>();

  var orderList = <OrderList>[].obs;
  var parentCategories = <ParentCategory>[].obs;
  var subCategories = <SubCategory>[].obs;

  var tabController = Rxn<TabController>();

  var selectedParentCategory = Rxn<ParentCategory>();
  var selectedSubCategory = Rxn<SubCategory>();

  var searchTextEditingController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    outletId = Get.arguments["outletId"];
    outletName = Get.arguments["outletName"];
    listId = Get.arguments["listId"];

    tabController.value = TabController(length: 2, vsync: this);
    selectedTab.value = 0;

    await getParentCategories();
    await getListOrders();
  }

  getListOrders() async {
    try {
      isLoading.value = true;
      orderList.clear();
      orderList.refresh();

      var response = orderListModelFromJson(
        await repository.getData(
          base: EndPoint.base_url_product,
          endpoint: EndPoint.get_list_orders,
          query: {
            "listId": listId,
            "parentCategoryId": selectedParentCategory.value?.id ?? "",
            "subCategoryId": selectedSubCategory.value?.id ?? "",
            "pageNumber": 1,
            "pageSize": 15,
            "searchText": searchTextEditingController.text,
          },
        ),
      );

      isLoading.value = false;

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

        orderList.forEach((element) async {
          element.imageFile = await getFile(orderList: element);
          orderList.refresh();
        });
      } else {
        repository.showMessage(
          title: AppLocalizations.of(Get.context!)!.error,
          message: response.message,
        );
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  getFile({required OrderList orderList}) async {
    var res = imageFileModelFromJson(
      await repository.getData(
          endpoint: EndPoint.getFile,
          base: EndPoint.base_url_product,
          query: {
            "folder": orderList.isCampaign ? "campaign" : "product",
            "fileName": orderList.productId,
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

  getCampaigns() async {
    orderList.clear();
    orderList.refresh();

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

      var basketController = Get.find<BasketController>();

      orderList.forEach((element) {
        element.isCampaign = true;
        var index = basketController.basketList.indexWhere(
            (basketElement) => basketElement.productId == element.productId);
        if (index != -1) {
          element.selectedCount =
              basketController.basketList[index].selectedCount;
        }
      });

      orderList.refresh();

      orderList.forEach((element) async {
        element.imageFile = await getFile(orderList: element);
      });

      orderList.refresh();

      orderList.forEach((element) async {
        element.imageFile = await getFile(orderList: element);
        orderList.refresh();
      });
    } else {
      repository.showMessage(
        title: AppLocalizations.of(Get.context!)!.error,
        message: response.message,
      );
    }
  }

  getParentCategories() async {
    isLoading.value = true;
    try {
      parentCategories.clear();
      var response = parentCategoriesModelFromJson(
        await repository.getData(
          base: EndPoint.base_url_product,
          endpoint: EndPoint.get_parent_categories,
        ),
      );
      isLoading.value = false;

      if (response.code == 200) {
        parentCategories.value = response.data;
        selectedParentCategory.value = response.data.first;
        await getSUbCategories();
      } else {
        repository.showMessage(
          title: AppLocalizations.of(Get.context!)!.error,
          message: response.message,
        );
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  getSUbCategories() async {
    try {
      isLoading.value = true;
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

      isLoading.value = false;

      if (response.code == 200) {
        subCategories.value = response.data;
        if (response.data.isNotEmpty) {
          selectedSubCategory.value = response.data.first;
        } else {
          selectedSubCategory.value = null;
        }
        await getListOrders();
      } else {
        repository.showMessage(
          title: AppLocalizations.of(Get.context!)!.error,
          message: response.message,
        );
      }
    } catch (e) {
      isLoading.value = false;
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
