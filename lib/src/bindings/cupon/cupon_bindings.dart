import 'package:get/get.dart';
import '../../controllers/coupon/cupon_controller.dart';
import '../../data/provider/api_client.dart';
import '../../data/repository/repository.dart';

class CouponBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CouponController>(
      () => CouponController(
        repository: Repository(
          apiClient: ApiClient(),
        ),
      ),
    );
  }
}
