import 'package:get/get.dart';
import '../../controllers/payment/payment_controller.dart';
import '../../controllers/product/product_controller.dart';
import '../../data/provider/api_client.dart';
import '../../data/repository/repository.dart';

class PaymentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentController>(
      () => PaymentController(
        repository: Repository(
          apiClient: ApiClient(),
        ),
      ),
    );
  }
}
