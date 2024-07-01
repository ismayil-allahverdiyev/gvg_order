import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/routes/app_routes.dart';
import 'package:gvg_order/src/ui/shared/widgets/custom_text_field_widget.dart';
import 'package:gvg_order/src/ui/theme/app_colors.dart';

import '../../controllers/outlets/outlets_controller.dart';
import 'widgets/lists_widget.dart';
import 'widgets/outlets_widget.dart';

class OutletsPage extends GetView<OutletsController> {
  const OutletsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: Get.height / 2,
            child: TabBarView(
              controller: controller.tabController!,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Obx(
                  () {
                    return OutletsWidget(
                      onTap: (int index) {
                        controller.selectedOutletId.value =
                            controller.outlistList[index].id;
                        controller.selectedOutletName.value =
                            controller.outlistList[index].properties.sigNName;

                        controller.getLists();

                        controller.tabController!.animateTo(1);
                      },
                      outlistList: controller.outlistList.value,
                      onChanged: (String value) {
                        controller.getOutletList();
                      },
                      searchController: controller.searchController,
                    );
                  },
                ),
                const ListsWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
