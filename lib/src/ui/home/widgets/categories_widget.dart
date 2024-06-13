import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 15,
      child: Container(
        color: whiteColor,
        child: TabBar(
          indicator: BoxDecoration(),
          indicatorColor: Colors.transparent,
          dividerColor: lightGreyColor.withOpacity(0.5),
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          dividerHeight: 0,
          tabs: [
            for (int i = 0; i < 15; i++)
              Tab(
                child: Text(
                  'Category $i',
                  style: const TextStyle(
                    color: greyColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
