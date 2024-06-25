import 'package:get/get.dart';
import 'package:gvg_order/src/data/models/kdv_products/kdv_products_model.dart';
import 'package:gvg_order/src/data/models/order_list/order_list_model.dart';
import '../../constants/endpoints.dart';
import '../../data/repository/repository.dart';

class BasketController extends GetxController {
  final Repository repository;
  BasketController({required this.repository});

  var basketList = <OrderList>[].obs;
  var kdvProducts = <KdvProduct>[].obs;
  var kdvTotal = 0.0.obs;
  var justKdvTotal = 0.0.obs;

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
    print(basketList);
    update(["basketList"]);

    getTemporaryCardInfo();
  }

  getTemporaryCardInfo() async {
    var response = kdvProductsModelFromJson(
      await repository.postData(
        base: EndPoint.base_url_product,
        endpoint: EndPoint.get_temporary_card_info,
        list: basketList.map(
          (e) {
            return {
              "id": e.productId,
              "listId": e.productListId,
              "isCampaign": false,
              "amount": e.selectedCount,
            };
          },
        ).toList(),
      ),
    );

    if (response.code == 200) {
      kdvProducts.value = response.data;

      kdvTotal.value = 0.0;
      justKdvTotal.value = 0.0;

      kdvProducts.forEach(
        (element) {
          kdvTotal.value += element.price * element.amount;
          justKdvTotal.value += element.kdv * element.amount;
        },
      );
    } else {
      repository.showMessage(
        title: "Error",
        message: response.message,
      );
    }
  }
}
