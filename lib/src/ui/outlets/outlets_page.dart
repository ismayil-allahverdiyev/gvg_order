import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/routes/app_routes.dart';
import 'package:gvg_order/src/ui/shared/widgets/custom_text_field_widget.dart';
import 'package:gvg_order/src/ui/theme/app_colors.dart';

import '../../controllers/outlets/outlets_controller.dart';

class OutletsPage extends GetView<OutletsController> {
  const OutletsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.HOME);
        },
        child: const Icon(Icons.refresh),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CustomTextField(
              hintText: "Search Outlet",
            ),
          ),
          Expanded(
            child: Obx(
              () {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: greyColor,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: whiteColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller
                                    .outlistList[index].properties.sigNName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              controller.outlistList[index].properties
                                          .legaLName ==
                                      null
                                  ? const SizedBox()
                                  : Text(
                                      controller.outlistList[index].properties
                                          .legaLName!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                              Text(
                                "${controller.outlistList[index].properties.country}/${controller.outlistList[index].properties.county}/${controller.outlistList[index].properties.city}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: controller.outlistList.length,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
