import 'package:get/get.dart';
import 'package:gvg_order/src/controllers/login/login_controller.dart';
import '../../controllers/coupon/cupon_controller.dart';
import '../../controllers/outlets/outlets_controller.dart';
import '../../data/provider/api_client.dart';
import '../../data/repository/repository.dart';

class OutletsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutletsController>(
      () => OutletsController(
        repository: Repository(
          apiClient: ApiClient(),
        ),
      ),
    );
  }
}
