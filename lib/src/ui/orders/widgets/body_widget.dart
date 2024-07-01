import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/orders/orders_controller.dart';
import '../../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BodyWidget extends GetWidget<OrdersController> {
  const BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () {
          return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  Get.toNamed(
                    Routes.CARD_DETAIL,
                    arguments: {
                      "cardId": controller.cardsList[index].cardId,
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.cardsList[index].cardCode,
                          style: const TextStyle(
                            color: redColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          controller.cardsList[index].outletName,
                          style: const TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: textColor,
                                    fontSize: 14,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: AppLocalizations.of(context)!
                                          .orderdate,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: DateFormat('yyyy-MM-dd')
                                          .format(controller
                                              .cardsList[index].createdDate)
                                          .toString(),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width:
                                  controller.cardsList[index].plannedDueDate ==
                                          null
                                      ? 0
                                      : 8,
                            ),
                            controller.cardsList[index].plannedDueDate == null
                                ? const SizedBox()
                                : Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          color: textColor,
                                          fontSize: 14,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: AppLocalizations.of(context)!
                                                .planneddate,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: DateFormat('yyyy-MM-dd')
                                                .format(controller
                                                    .cardsList[index]
                                                    .plannedDueDate!)
                                                .toString(),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  color: textColor,
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!
                                        .paymenttypes,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: controller.cardsList[index].isPayment
                                        ? AppLocalizations.of(context)!.paid
                                        : AppLocalizations.of(context)!.notpaid,
                                  )
                                ],
                              ),
                            )),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  color: textColor,
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!
                                        .totalwithspace,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "${controller.cardsList[index].totalPrice} TL",
                                  )
                                ],
                              ),
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 8,
              );
            },
            itemCount: controller.cardsList.length,
          );
        },
      ),
    );
  }
}
