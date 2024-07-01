import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/constants/local_storage.dart';
import 'package:gvg_order/src/controllers/orders/orders_controller.dart';
import 'package:intl/intl.dart';

import '../../theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DateSelectorWidget extends GetWidget<OrdersController> {
  const DateSelectorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () async {
              controller.selectedStartDate.value = await showDatePicker(
                context: context,
                helpText: "Select a start date",
                firstDate: DateTime.now().add(const Duration(days: -3650)),
                lastDate: DateTime.now(),
                currentDate: DateTime.now(),
                locale: Locale(
                  controller.localStorageController.getStringFromLocal(
                            LocalStorageConst.language,
                          ) ==
                          ""
                      ? "tr"
                      : controller.localStorageController.getStringFromLocal(
                          LocalStorageConst.language,
                        ),
                ),
              );

              if (controller.selectedEndDate.value != null &&
                  controller.selectedStartDate.value != null &&
                  controller.selectedStartDate.value!
                      .isAfter(controller.selectedEndDate.value!)) {
                controller.selectedEndDate.value =
                    controller.selectedStartDate.value;
              }

              controller.cards();
            },
            child: Container(
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: lightGreyColor,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () {
                          return Text(
                            controller.selectedStartDate.value == null
                                ? AppLocalizations.of(context)!.startdate
                                : DateFormat('yyyy-MM-dd').format(
                                    controller.selectedStartDate.value!),
                            style: const TextStyle(
                              color: lightGreyColor,
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                    ),
                    Obx(() {
                      return IconButton(
                        onPressed: () async {
                          if (controller.selectedStartDate.value != null) {
                            controller.selectedStartDate.value = null;
                            await controller.cards();
                          }
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: controller.selectedStartDate.value == null
                              ? lightGreyColor
                              : redColor,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () async {
              controller.selectedEndDate.value = await showDatePicker(
                context: context,
                helpText: AppLocalizations.of(context)!.selectanenddate,
                firstDate: DateTime.now().add(const Duration(days: -3650)),
                lastDate: DateTime.now(),
                currentDate: DateTime.now(),
                locale: Locale(
                  controller.localStorageController.getStringFromLocal(
                            LocalStorageConst.language,
                          ) ==
                          ""
                      ? "tr"
                      : controller.localStorageController.getStringFromLocal(
                          LocalStorageConst.language,
                        ),
                ),
              );

              if (controller.selectedEndDate.value != null &&
                  controller.selectedStartDate.value != null &&
                  controller.selectedEndDate.value!
                      .isBefore(controller.selectedStartDate.value!)) {
                controller.selectedStartDate.value =
                    controller.selectedEndDate.value;
              }

              controller.cards();
            },
            child: Container(
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: lightGreyColor,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () {
                          return Text(
                            controller.selectedEndDate.value == null
                                ? AppLocalizations.of(context)!.enddate
                                : DateFormat('yyyy-MM-dd')
                                    .format(controller.selectedEndDate.value!),
                            style: const TextStyle(
                              color: lightGreyColor,
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                    ),
                    Obx(
                      () {
                        return IconButton(
                          onPressed: () async {
                            if (controller.selectedEndDate.value != null) {
                              controller.selectedEndDate.value = null;
                              await controller.cards();
                            }
                          },
                          icon: Icon(
                            Icons.cancel,
                            color: controller.selectedEndDate.value == null
                                ? lightGreyColor
                                : redColor,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
