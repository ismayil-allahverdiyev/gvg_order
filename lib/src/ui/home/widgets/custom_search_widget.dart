import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/widgets/custom_text_field_widget.dart';
import '../../theme/app_colors.dart';

class CustomSearchWidget extends StatelessWidget {
  final Function(String) onSearch;
  final TextEditingController controller;

  const CustomSearchWidget({
    super.key,
    required this.onSearch,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      toolbarHeight: kToolbarHeight + 16,
      flexibleSpace: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                top: 12,
                bottom: 4,
              ),
              child: CustomTextField(
                  hintText: 'Search',
                  controller: controller,
                  onChanged: onSearch,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: lightGreyColor,
                  )),
            ),
          ),
          Container(
            width: Get.width,
            height: 1,
            color: lightGreyColor.withOpacity(0.5),
          )
        ],
      ),
      leading: const SizedBox(),
      backgroundColor: Colors.transparent,
    );
  }
}
