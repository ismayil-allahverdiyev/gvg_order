import 'package:get/get.dart';
import '../../data/repository/repository.dart';

class ProductController extends GetxController {
  final Repository repository;
  ProductController({required this.repository});

  var productId = "";
  var selectedCount = 0.obs;
  var availableProductCount = 5;

  @override
  void onInit() {
    super.onInit();

    productId = Get.arguments["productId"];
    selectedCount.value = Get.arguments["selectedCount"];
    availableProductCount = Get.arguments["availableProductCount"];
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
}
