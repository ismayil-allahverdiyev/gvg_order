import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gvg_order/src/ui/theme/app_colors.dart';
import 'widgets/basket_product_widget.dart';
import 'widgets/bottom_bar_widget.dart';

class BasketPage extends StatelessWidget {
  const BasketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text(
          'My basket',
          style: TextStyle(
            color: lightTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.xmark,
            color: lightTextColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              CupertinoIcons.trash,
              color: lightTextColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => BasketProductWidget(
                index: index,
              ),
            ),
          ),
          const Divider(),
          const BottomBarWidget()
        ],
      ),
    );
  }
}
