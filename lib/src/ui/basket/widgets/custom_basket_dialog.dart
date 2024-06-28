import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/controllers/basket/basket_controller.dart';
import 'package:gvg_order/src/ui/shared/widgets/custom_dialog_widget.dart';
import 'package:gvg_order/src/ui/theme/app_colors.dart';

class CustomBasketDialog extends GetWidget<BasketController> {
  const CustomBasketDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDialogWidget(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Get.height * 0.5,
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Select Delivery Date",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: lightTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 3650)),
                onDateChanged: (DateTime? date) {
                  if (date != null) controller.selectedDate.value = date;
                },
              ),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              controller.cardInfo();
            },
            child: Container(
              height: Get.width * 0.12,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  "Finish payment",
                  style: TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
