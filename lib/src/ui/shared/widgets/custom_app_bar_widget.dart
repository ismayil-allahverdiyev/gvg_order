import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'basket_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBasketVisible;
  final VoidCallback? onPressed;
  final bool isBackButton;
  const CustomAppBar({
    super.key,
    required this.title,
    required this.isBasketVisible,
    this.onPressed,
    this.isBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
      ),
      leading: IconButton(
        icon: Icon(
          isBackButton ? Icons.arrow_back_ios_new_rounded : Icons.menu,
        ),
        onPressed: onPressed ?? () => Get.back(),
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
