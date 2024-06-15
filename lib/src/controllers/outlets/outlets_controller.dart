import 'package:get/get.dart';
import 'package:gvg_order/src/constants/endpoints.dart';
import 'package:gvg_order/src/data/models/outlet_list/outlet_list_model.dart';
import '../../data/repository/repository.dart';

class OutletsController extends GetxController {
  final Repository repository;
  OutletsController({required this.repository});

  var outlistList = <OutLet>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getOutletList();
  }

  getOutletList() async {
    var res = outletListModelFromJson(
      await repository.postData(
        endpoint: EndPoint.get_outlet_list_gvg,
        base: EndPoint.base_url_product,
      ),
    );

    if (!res.status) {
      repository.showMessage(title: "Error", message: res.message);
    } else {
      outlistList.value = res.data;
    }
  }
}
