import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gvg_order/src/ui/theme/app_colors.dart';

class BasketBackgroundWidget extends StatelessWidget {
  const BasketBackgroundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: redColor.withOpacity(0.1),
      child: const Padding(
        padding: EdgeInsets.only(right: 16.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.delete,
                color: redColor,
              ),
              Text(
                "Delete",
                style: TextStyle(
                  color: redColor,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
