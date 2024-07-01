import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/controllers/orders/orders_controller.dart';
import 'package:gvg_order/src/ui/home/home_page.dart';
import 'package:gvg_order/src/ui/home/widgets/custom_search_widget.dart';
import 'package:gvg_order/src/ui/orders/widgets/outlet_selector_widget.dart';
import 'package:gvg_order/src/ui/outlets/widgets/outlets_widget.dart';
import 'package:gvg_order/src/ui/shared/widgets/custom_app_bar_widget.dart';
import 'package:gvg_order/src/ui/shared/widgets/custom_dialog_widget.dart';
import 'package:intl/intl.dart';

import '../../data/utils/device_utils.dart';
import '../../routes/app_routes.dart';
import '../shared/widgets/custom_text_field_widget.dart';
import '../theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widgets/body_widget.dart';
import 'widgets/date_selector_widget.dart';

class OrdersPage extends GetView<OrdersController> {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            DeviceUtils.hideKeyboard(context);
          },
          child: Scaffold(
            appBar: CustomAppBar(
              title: AppLocalizations.of(context)!.previousorders,
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
                    hintText: AppLocalizations.of(context)!.search,
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
                  const DateSelectorWidget(),
                  const SizedBox(
                    height: 8,
                  ),
                  const OutletSelectorWidget(),
                  const SizedBox(
                    height: 8,
                  ),
                  const BodyWidget(),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.OUTLETS);
                    },
                    child: Container(
                      width: Get.width - 8,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "Create a new order",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          child: Obx(
            () {
              return controller.isLoading.value
                  ? Container(
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : const SizedBox();
            },
          ),
        )
      ],
    );
  }
}
