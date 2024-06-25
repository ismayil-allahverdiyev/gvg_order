import 'package:get/get.dart';
import 'package:gvg_order/src/data/models/product/product_detail_model.dart';
import '../../constants/endpoints.dart';
import '../../data/repository/repository.dart';

class ProductController extends GetxController {
  final Repository repository;
  ProductController({required this.repository});

  var productId = "";
  var selectedCount = 0.obs;
  var availableProductCount = 5;

  var productDetail = Rxn<ProductData>();

  @override
  void onInit() async {
    super.onInit();

    productId = Get.arguments["productId"];
    selectedCount.value = Get.arguments["selectedCount"];
    availableProductCount = Get.arguments["availableProductCount"];

    await getProductDetail();
  }

  addToBasket() {
    if (selectedCount.value < availableProductCount) {
      selectedCount.value++;
    } else {
      repository.showMessage(
        title: "Quota restriction",
        message: "There are no more products available in the stock!",
      );
    }
  }

  removeFromBasket() {
    selectedCount.value--;
  }

  getProductDetail() async {
    var response = productDetailModelFromJson(
      await repository.getData(
        base: EndPoint.base_url_product,
        endpoint: EndPoint.get_detail_order,
        query: {
          "id": productId,
          "listId": "149e56b0-af99-4262-b4a8-78967c6b6bcc",
          "isCampaign": false,
        },
      ),
    );

    if (response.code == 200) {
      productDetail.value = response.data;
    } else {
      repository.showMessage(
        title: "Error",
        message: response.message,
      );
    }
  }
}
