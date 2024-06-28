import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home/home_controller.dart';
import '../../theme/app_colors.dart';

class CategoriesWidget extends GetWidget<HomeController> {
  const CategoriesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return DefaultTabController(
          length: controller.parentCategories.length,
          child: Container(
            color: whiteColor,
            width: Get.width,
            child: TabBar(
              indicator: const BoxDecoration(),
              indicatorColor: Colors.transparent,
              dividerColor: lightGreyColor.withOpacity(0.5),
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              dividerHeight: 0,
              onTap: (value) async {
                controller.selectedParentCategory.value =
                    controller.parentCategories[value];
                await controller.getSUbCategories();
              },
              tabs: [
                for (int i = 0; i < controller.parentCategories.length; i++)
                  Tab(
                    child: Text(
                      controller.parentCategories[i].name,
                      style: const TextStyle(
                        color: greyColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
