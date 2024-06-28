import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';

class CustomDialogWidget extends StatelessWidget {
  final List<Widget> children;
  final double? width;
  final double? height;
  final CrossAxisAlignment? crossAxisAlignment;

  const CustomDialogWidget({
    super.key,
    required this.children,
    this.height,
    this.width,
    this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: width ?? Get.width * 0.9,
          height: height ?? Get.height * 0.7,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Material(
              color: whiteColor,
              borderRadius: BorderRadius.circular(8),
              child: Column(
                crossAxisAlignment:
                    crossAxisAlignment ?? CrossAxisAlignment.center,
                children: children,
              ),
            ),
          ),
        )
      ],
    );
  }
}
