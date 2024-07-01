import 'package:get/get.dart';
import '../../controllers/card_detail/card_detail_controller.dart';
import '../../controllers/coupon/cupon_controller.dart';
import '../../data/provider/api_client.dart';
import '../../data/repository/repository.dart';

class CardDetailBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CardDetailController>(
      () => CardDetailController(
        repository: Repository(
          apiClient: ApiClient(),
        ),
      ),
    );
  }
}
