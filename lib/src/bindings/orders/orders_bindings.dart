import 'package:get/get.dart';
import '../../controllers/orders/orders_controller.dart';
import '../../data/provider/api_client.dart';
import '../../data/repository/repository.dart';

class OrdersBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrdersController>(
      () => OrdersController(
        repository: Repository(
          apiClient: ApiClient(),
        ),
      ),
    );
  }
}
