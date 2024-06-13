import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'basket_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBasketVisible;
  const CustomAppBar({
    super.key,
    required this.title,
    required this.isBasketVisible,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      actions: isBasketVisible
          ? [
              BasketWidget(),
            ]
          : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
