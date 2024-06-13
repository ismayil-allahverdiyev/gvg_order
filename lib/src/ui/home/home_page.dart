import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/data/utils/device_utils.dart';
import 'package:gvg_order/src/ui/theme/app_colors.dart';

import '../shared/widgets/basket_widget.dart';
import '../shared/widgets/custom_app_bar_widget.dart';
import '../shared/widgets/custom_text_field_widget.dart';
import 'widgets/body_widget.dart';
import 'widgets/custom_search_widget.dart';
import 'widgets/general_categories_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DeviceUtils.hideKeyboard(context);
      },
      child: const Scaffold(
        appBar: CustomAppBar(
          title: "Home Page",
          isBasketVisible: true,
        ),
        backgroundColor: whiteColor,
        body: CustomScrollView(
          slivers: <Widget>[
            CustomSearchWidget(),
            GeneralCategoriesWidget(),
            BodyWidget(),
          ],
        ),
      ),
    );
  }
}
