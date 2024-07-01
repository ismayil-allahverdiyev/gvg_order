import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home/home_controller.dart';
import '../../theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubCategoryWidget extends GetWidget<HomeController> {
  const SubCategoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.subCategories.isEmpty
          ? const SizedBox()
          : DefaultTabController(
              length: controller.subCategories.length,
              child: Container(
                width: Get.width,
                color: const Color.fromARGB(255, 243, 243, 243),
                child: TabBar(
                  indicator: const BoxDecoration(),
                  indicatorColor: Colors.transparent,
                  dividerColor: lightGreyColor.withOpacity(0.5),
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  dividerHeight: 0,
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  onTap: (value) async {
                    controller.selectedSubCategory.value =
                        controller.subCategories[value];
                    await controller.getListOrders();
                  },
                  tabs: [
                    for (int i = 0; i < controller.subCategories.length; i++)
                      Tab(
                        child: Obx(
                          () {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: whiteColor,
                                border: Border.all(
                                  color: controller.selectedSubCategory.value ==
                                          controller.subCategories[i]
                                      ? primaryColor
                                      : lightGreyColor,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 6,
                                ),
                                child: Text(
                                  controller.subCategories[i].name,
                                  style: const TextStyle(
                                    color: greyColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            );
    });
  }
}
