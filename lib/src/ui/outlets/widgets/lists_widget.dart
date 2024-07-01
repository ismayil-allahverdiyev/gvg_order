import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/outlets/outlets_controller.dart';
import '../../../routes/app_routes.dart';
import '../../shared/widgets/custom_text_field_widget.dart';
import '../../theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListsWidget extends GetWidget<OutletsController> {
  const ListsWidget({
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
              Text(
                AppLocalizations.of(context)!.lists,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.selectalisttostartshopping,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: lightTextColor,
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
                              controller.selectedListId.value =
                                  controller.listsList[index].id;
                              Get.toNamed(
                                Routes.HOME,
                                arguments: {
                                  "listId": controller.listsList[index].id,
                                  "outletId": controller.selectedOutletId.value,
                                  "outletName":
                                      controller.selectedOutletName.value,
                                },
                              );
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
                                            controller.listsList[index].name,
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
                                            "${DateFormat('yyyy-MM-dd').format(controller.listsList[index].beginDate)} - ${DateFormat("yyyy-MM-dd").format(controller.listsList[index].endDate)}",
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
                      itemCount: controller.listsList.length,
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
