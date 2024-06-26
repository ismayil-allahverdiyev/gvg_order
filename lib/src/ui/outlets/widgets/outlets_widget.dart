import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/outlets/outlets_controller.dart';
import '../../shared/widgets/custom_text_field_widget.dart';
import '../../theme/app_colors.dart';

class OutletsWidget extends GetWidget<OutletsController> {
  const OutletsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: lightGreyColor,
              blurRadius: 2,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Outlets",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const Text(
                "Select an outlet to continue",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: lightTextColor,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
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
                            vertical: 4,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              controller.selectedOutletId.value =
                                  controller.outlistList[index].id;
                              controller.selectedOutletName.value = controller
                                  .outlistList[index].properties.sigNName;

                              controller.getLists();

                              controller.tabController!.animateTo(1);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: lightGreyColor,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: whiteColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: Get.width / 4 * 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.outlistList[index]
                                                .properties.sigNName,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          controller.outlistList[index]
                                                      .properties.legaLName ==
                                                  null
                                              ? const SizedBox()
                                              : Text(
                                                  controller.outlistList[index]
                                                      .properties.legaLName!,
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
                                    const Spacer(),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: primaryColor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: controller.outlistList.length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
