import 'package:flutter/material.dart';
import 'package:gvg_order/src/ui/home/widgets/categories_widget.dart';
import 'sub_categories_widget.dart';

class GeneralCategoriesWidget extends StatelessWidget {
  const GeneralCategoriesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      floating: true,
      pinned: true,
      expandedHeight: kToolbarHeight * 2,
      toolbarHeight: kToolbarHeight * 2,
      foregroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      flexibleSpace: Column(
        children: [
          CategoriesWidget(),
          SubCategoryWidget(),
        ],
      ),
      leading: const SizedBox(),
      backgroundColor: Colors.transparent,
    );
  }
}
