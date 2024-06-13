import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class SubCategoryWidget extends StatelessWidget {
  const SubCategoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 15,
      child: Container(
        color: const Color.fromARGB(255, 243, 243, 243),
        child: TabBar(
          indicator: const BoxDecoration(),
          indicatorColor: Colors.transparent,
          dividerColor: lightGreyColor.withOpacity(0.5),
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          dividerHeight: 0,
          indicatorPadding: EdgeInsets.zero,
          labelPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          tabs: [
            for (int i = 0; i < 15; i++)
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: whiteColor,
                    border: Border.all(
                      color: lightGreyColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 6,
                    ),
                    child: Text(
                      'SCategory $i',
                      style: const TextStyle(
                        color: greyColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
