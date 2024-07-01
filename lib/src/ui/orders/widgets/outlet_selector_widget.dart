import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/orders/orders_controller.dart';
import '../../outlets/widgets/outlets_widget.dart';
import '../../shared/widgets/custom_dialog_widget.dart';
import '../../theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OutletSelectorWidget extends GetWidget<OrdersController> {
  const OutletSelectorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                      onChanged: (value) {
                        controller.getOutletList();
                      },
                      searchController: controller.searchController,
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
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Obx(
                  () {
                    return Text(
                      controller.selectedOutlet.value != null
                          ? controller.selectedOutlet.value!.properties.sigNName
                          : AppLocalizations.of(context)!.outlet,
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
                      if (controller.selectedOutlet.value != null) {
                        controller.selectedOutlet.value = null;
                        await controller.cards();
                      }
                    },
                    icon: Icon(
                      Icons.cancel,
                      color: controller.selectedOutlet.value == null
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
    );
  }
}
