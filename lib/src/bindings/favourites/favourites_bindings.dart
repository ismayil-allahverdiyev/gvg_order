import 'package:get/get.dart';
import '../../controllers/favourites/favourites_controller.dart';
import '../../data/provider/api_client.dart';
import '../../data/repository/repository.dart';

class FavouritesBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavouritesController>(
      () => FavouritesController(
        repository: Repository(
          apiClient: ApiClient(),
        ),
      ),
    );
  }
}
