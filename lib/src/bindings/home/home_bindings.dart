import 'package:get/get.dart';
import 'package:gvg_order/src/controllers/basket/basket_controller.dart';
import '../../controllers/home/home_controller.dart';
import '../../data/provider/api_client.dart';
import '../../data/repository/repository.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        repository: Repository(
          apiClient: ApiClient(),
        ),
      ),
    );

    Get.lazyPut<BasketController>(
      () => BasketController(
        repository: Repository(
          apiClient: ApiClient(),
        ),
      ),
    );
  }
}
