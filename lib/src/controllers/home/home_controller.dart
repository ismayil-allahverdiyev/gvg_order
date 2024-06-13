import 'package:get/get.dart';
import '../../data/repository/repository.dart';

class HomeController extends GetxController {
  final Repository repository;
  HomeController({required this.repository});

  var openIndex = Rxn<int>();

  @override
  void onInit() {
    super.onInit();
  }
}
