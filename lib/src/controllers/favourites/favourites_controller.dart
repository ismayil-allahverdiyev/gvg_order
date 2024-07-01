import 'package:get/get.dart';
import 'package:gvg_order/src/constants/endpoints.dart';
import 'package:gvg_order/src/data/models/favourites/favourites_model.dart';
import '../../data/repository/repository.dart';

class FavouritesController extends GetxController {
  final Repository repository;

  FavouritesController({required this.repository});

  var favourites = <FavouriteModel>[].obs;

  @override
  void onInit() async {
    super.onInit();

    await getFavourites();
  }

  getFavourites() async {
    var res = favouritesModelFromJson(
      await repository.getData(
        endpoint: EndPoint.getFavourites,
        base: EndPoint.base_url_product,
      ),
    );

    if (res.code == 200) {
      favourites.assignAll(res.data);
    } else {
      repository.showMessage(
        title: 'Error',
        message: res.message,
      );
    }
  }
}
