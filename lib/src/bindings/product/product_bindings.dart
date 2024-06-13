import 'package:get/get.dart';
import '../../controllers/product/product_controller.dart';
import '../../data/provider/api_client.dart';
import '../../data/repository/repository.dart';

class ProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(
      () => ProductController(
        repository: Repository(
          apiClient: ApiClient(),
        ),
      ),
    );
  }
}
