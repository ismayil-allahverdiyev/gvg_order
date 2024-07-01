import 'package:get/get.dart';
import 'package:gvg_order/src/controllers/orders/orders_controller.dart';
import 'package:gvg_order/src/data/models/general/general_model.dart';
import 'package:gvg_order/src/data/models/kdv_products/kdv_products_model.dart';
import 'package:gvg_order/src/data/models/order_list/order_list_model.dart';
import '../../constants/endpoints.dart';
import '../../data/repository/repository.dart';
import '../home/home_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BasketController extends GetxController {
  final Repository repository;
  BasketController({required this.repository});

  var isLoading = false.obs;

  var basketList = <OrderList>[].obs;
  var kdvProducts = <KdvProduct>[].obs;
  var total = 0.0.obs;
  var kdvTotal = 0.0.obs;
  var justKdvTotal = 0.0.obs;

  var selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
  }

  editBasketList({required OrderList orderList}) async {
    var index = basketList
        .indexWhere((element) => element.productId == orderList.productId);
    if (index == -1) {
      basketList.add(orderList);
    } else {
      if (orderList.selectedCount == 0) {
        basketList.removeAt(index);
      } else {
        basketList[index] = orderList;
      }
    }

    basketList.refresh();
    total.value = basketList.fold(
      0,
      (previous, current) =>
          previous +
          (current.discountedListPrice != current.listPrice &&
                      current.discountedListPrice != 0
                  ? current.discountedListPrice
                  : current.listPrice) *
              current.selectedCount,
    );
    print(basketList);

    update(["basketList"]);

    getTemporaryCardInfo();
  }

  getTemporaryCardInfo() async {
    try {
      isLoading.value = true;
      var response = kdvProductsModelFromJson(
        await repository.postData(
          base: EndPoint.base_url_product,
          endpoint: EndPoint.get_temporary_card_info,
          list: basketList.map(
            (e) {
              return {
                "id": e.productId,
                "listId": e.productListId,
                "isCampaign": e.isCampaign,
                "amount": e.selectedCount,
              };
            },
          ).toList(),
        ),
      );

      isLoading.value = false;

      if (response.code == 200) {
        kdvProducts.value = response.data;

        kdvTotal.value = 0.0;
        justKdvTotal.value = 0.0;

        kdvProducts.forEach(
          (element) {
            kdvTotal.value += element.price;
            justKdvTotal.value += element.kdv;
          },
        );
      } else {
        repository.showMessage(
          title: AppLocalizations.of(Get.context!)!.error,
          message: response.message,
        );
      }
    } catch (e) {
      isLoading.value = false;
      repository.showMessage(
        title: AppLocalizations.of(Get.context!)!.error,
        message: e.toString(),
      );
    }
  }

  cardInfo() async {
    var homeController = Get.find<HomeController>();

    try {
      isLoading.value = true;

      Get.back();

      var response = generalModelFromJson(
        await repository.postData(
          base: EndPoint.base_url_product,
          endpoint: EndPoint.cardInfo,
          object: {
            "model": basketList.map(
              (e) {
                return {
                  "id": e.productId,
                  "listId": e.productListId,
                  "isCampaign": e.isCampaign,
                  "amount": e.selectedCount,
                };
              },
            ).toList(),
            "cardInfo": {
              "plannedDueDate": selectedDate.value.toIso8601String() + "Z",
              "outletId": homeController.outletId,
              "outletName": homeController.outletName,
              "isPayment": false,
            }
          },
        ),
      );

      isLoading.value = false;

      if (response.code == 200) {
        basketList.clear();
        total.value = 0.0;
        kdvTotal.value = 0.0;
        justKdvTotal.value = 0.0;
        Get.close(3);
        var ordersController = Get.find<OrdersController>();
        await ordersController.cards();
      } else {
        repository.showMessage(
          title: AppLocalizations.of(Get.context!)!.error,
          message: response.message ?? "",
        );
      }
    } catch (e) {
      isLoading.value = false;
      repository.showMessage(
        title: AppLocalizations.of(Get.context!)!.error,
        message: e.toString(),
      );
    }
  }
}
