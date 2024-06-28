import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/data/models/outlet_list/outlet_list_model.dart';
import '../../../controllers/outlets/outlets_controller.dart';
import '../../shared/widgets/custom_text_field_widget.dart';
import '../../theme/app_colors.dart';

class OutletsWidget extends StatelessWidget {
  final Function(int) onTap;
  final List<OutLet> outlistList;
  final bool hasPadding;
  const OutletsWidget({
    super.key,
    required this.onTap,
    required this.outlistList,
    this.hasPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: hasPadding ? 16 : 0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: lightGreyColor,
              blurRadius: 2,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Outlets",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const Text(
                "Select an outlet to continue",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: lightTextColor,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: CustomTextField(
                  hintText: "Search Outlet",
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          onTap(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: lightGreyColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: whiteColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: Get.width / 4 * 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        outlistList[index].properties.sigNName,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      outlistList[index].properties.legaLName ==
                                              null
                                          ? const SizedBox()
                                          : Text(
                                              outlistList[index]
                                                  .properties
                                                  .legaLName!,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                      Text(
                                        "${outlistList[index].properties.country}/${outlistList[index].properties.county}/${outlistList[index].properties.city}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: primaryColor,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: outlistList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
