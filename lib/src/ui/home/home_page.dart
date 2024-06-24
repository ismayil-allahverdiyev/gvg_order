import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/data/utils/device_utils.dart';
import 'package:gvg_order/src/ui/theme/app_colors.dart';

import '../../controllers/home/home_controller.dart';
import '../shared/widgets/basket_widget.dart';
import '../shared/widgets/custom_app_bar_widget.dart';
import '../shared/widgets/custom_text_field_widget.dart';
import 'widgets/body_widget.dart';
import 'widgets/custom_search_widget.dart';
import 'widgets/general_categories_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DeviceUtils.hideKeyboard(context);
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Home Page",
          isBasketVisible: true,
        ),
        backgroundColor: whiteColor,
        body: CustomScrollView(
          slivers: <Widget>[
            CustomSearchWidget(
              onSearch: (value) async {
                if (value.isNotEmpty) {
                  controller.selectedParentCategory.value = null;
                  controller.selectedSubCategory.value = null;
                } else {
                  controller.selectedParentCategory.value =
                      controller.parentCategories.first;
                  if (controller.subCategories.isNotEmpty) {
                    controller.selectedSubCategory.value =
                        controller.subCategories.first;
                  }
                }
                await controller.getListOrders();
              },
              controller: controller.searchTextEditingController,
            ),
            const GeneralCategoriesWidget(),
            const BodyWidget(),
          ],
        ),
      ),
    );
  }
}
