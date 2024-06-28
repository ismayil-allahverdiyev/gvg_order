import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/controllers/orders/orders_controller.dart';
import 'package:gvg_order/src/ui/home/widgets/custom_search_widget.dart';
import 'package:gvg_order/src/ui/outlets/widgets/outlets_widget.dart';
import 'package:gvg_order/src/ui/shared/widgets/custom_app_bar_widget.dart';
import 'package:gvg_order/src/ui/shared/widgets/custom_dialog_widget.dart';
import 'package:intl/intl.dart';

import '../../data/utils/device_utils.dart';
import '../shared/widgets/custom_text_field_widget.dart';
import '../theme/app_colors.dart';

class OrdersPage extends GetView<OrdersController> {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DeviceUtils.hideKeyboard(context);
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Previous orders",
          isBasketVisible: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              CustomTextField(
                hintText: 'Search',
                controller: controller.searchController,
                onChanged: (value) {
                  controller.cards();
                },
                prefixIcon: const Icon(
                  Icons.search,
                  color: lightGreyColor,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        controller.selectedStartDate.value =
                            await showDatePicker(
                          context: context,
                          helpText: "Select a start date",
                          firstDate:
                              DateTime.now().add(const Duration(days: -3650)),
                          lastDate: DateTime.now(),
                          currentDate: DateTime.now(),
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
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(
                            () {
                              return Text(
                                controller.selectedStartDate.value == null
                                    ? "Start date"
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
                          helpText: "Select an end date",
                          firstDate:
                              DateTime.now().add(const Duration(days: -3650)),
                          lastDate: DateTime.now(),
                          currentDate: DateTime.now(),
                        );

                        if (controller.selectedEndDate.value != null &&
                            controller.selectedStartDate.value != null &&
                            controller.selectedEndDate.value!.isBefore(
                                controller.selectedStartDate.value!)) {
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
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(
                            () {
                              return Text(
                                controller.selectedEndDate.value == null
                                    ? "End date"
                                    : DateFormat('yyyy-MM-dd').format(
                                        controller.selectedEndDate.value!),
                                style: const TextStyle(
                                  color: lightGreyColor,
                                  fontSize: 12,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () {
                  Get.dialog(
                    CustomDialogWidget(
                      children: [
                        Expanded(
                          child: Obx(
                            () {
                              return OutletsWidget(
                                onTap: (value) {
                                  controller.selectedOutlet.value =
                                      controller.outlistList[value];
                                  Get.back();
                                  controller.cards();
                                },
                                hasPadding: false,
                                outlistList: controller.outlistList.value,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  );
                },
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: lightGreyColor,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Outlet name will be here",
                      style: TextStyle(
                        color: lightGreyColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: Obx(
                  () {
                    return ListView.separated(
                      shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(8),
                            // border: Border.all(
                            //   color: lightGreyColor,
                            // ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.cardsList[index].cardCode,
                                  style: const TextStyle(
                                    color: redColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  controller.cardsList[index].outletName,
                                  style: const TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            color: textColor,
                                            fontSize: 14,
                                          ),
                                          children: [
                                            const TextSpan(
                                              text: "Order date: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: DateFormat('yyyy-MM-dd')
                                                  .format(controller
                                                      .cardsList[index]
                                                      .createdDate)
                                                  .toString(),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: controller.cardsList[index]
                                                  .plannedDueDate ==
                                              null
                                          ? 0
                                          : 8,
                                    ),
                                    controller.cardsList[index]
                                                .plannedDueDate ==
                                            null
                                        ? const SizedBox()
                                        : Expanded(
                                            child: RichText(
                                              text: TextSpan(
                                                style: const TextStyle(
                                                  color: textColor,
                                                  fontSize: 14,
                                                ),
                                                children: [
                                                  const TextSpan(
                                                    text: "Planned date: ",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: DateFormat(
                                                            'yyyy-MM-dd')
                                                        .format(controller
                                                            .cardsList[index]
                                                            .plannedDueDate!)
                                                        .toString(),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          color: textColor,
                                          fontSize: 14,
                                        ),
                                        children: [
                                          const TextSpan(
                                            text: "Payment types: ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: controller
                                                    .cardsList[index].isPayment
                                                ? "Paid"
                                                : "Not paid",
                                          )
                                        ],
                                      ),
                                    )),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        child: RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          color: textColor,
                                          fontSize: 14,
                                        ),
                                        children: [
                                          const TextSpan(
                                            text: "Total: ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                "${controller.cardsList[index].totalPrice} TL",
                                          )
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 8,
                        );
                      },
                      itemCount: controller.cardsList.length,
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
