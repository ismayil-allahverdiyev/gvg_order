import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/routes/app_routes.dart';

import '../../theme/app_colors.dart';

class BasketWidget extends StatelessWidget {
  const BasketWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Get.toNamed(Routes.BASKET);
        },
        child: Container(
          height: Get.width * 0.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Row(
            children: [
              SizedBox(
                width: Get.width * 0.1,
              ),
              Container(
                width: Get.width * 0.1,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  color: primaryColor.withOpacity(0.1),
                ),
                child: const Center(
                  child: Text(
                    '24tl',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
