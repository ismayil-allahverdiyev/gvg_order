import 'package:flutter/material.dart';
import 'product_display_widget.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (BuildContext context, int index) {
        return ProductDisplayWidget(
          index: index,
        );
      },
      itemCount: 30,
    );
  }
}
