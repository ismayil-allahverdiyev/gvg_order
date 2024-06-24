import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/ui/home/widgets/categories_widget.dart';
import '../../../controllers/home/home_controller.dart';
import 'sub_categories_widget.dart';

class GeneralCategoriesWidget extends GetWidget<HomeController> {
  const GeneralCategoriesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return SliverAppBar(
          floating: true,
          pinned: true,
          expandedHeight: controller.selectedParentCategory.value == null
              ? 0
              : controller.subCategories.isEmpty
                  ? kToolbarHeight
                  : kToolbarHeight * 2,
          toolbarHeight: controller.selectedParentCategory.value == null
              ? 0
              : controller.subCategories.isEmpty
                  ? kToolbarHeight
                  : kToolbarHeight * 2,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          flexibleSpace: Obx(
            () {
              return Column(
                children: controller.selectedParentCategory.value == null
                    ? []
                    : [
                        const CategoriesWidget(),
                        const SubCategoryWidget(),
                      ],
              );
            },
          ),
          leading: const SizedBox(),
          backgroundColor: Colors.transparent,
        );
      },
    );
  }
}
