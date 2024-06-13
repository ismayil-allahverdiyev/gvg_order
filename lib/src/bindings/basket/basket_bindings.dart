import 'package:get/get.dart';
import '../../controllers/basket/basket_controller.dart';
import '../../data/provider/api_client.dart';
import '../../data/repository/repository.dart';

class BasketBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BasketController>(
      () => BasketController(
        repository: Repository(
          apiClient: ApiClient(),
        ),
      ),
    );
  }
}
