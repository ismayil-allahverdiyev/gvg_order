import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/controllers/favourites/favourites_controller.dart';
import 'package:gvg_order/src/ui/shared/widgets/custom_app_bar_widget.dart';

class FavouritesPage extends GetView<FavouritesController> {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Favourites',
        isBasketVisible: false,
      ),
      body: Obx(
        () {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(controller.favourites[index].productId),
                subtitle:
                    Text(controller.favourites[index].customerId.toString()),
              );
            },
            itemCount: controller.favourites.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
          );
        },
      ),
    );
  }
}
