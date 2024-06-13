import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gvg_order/src/ui/basket/widgets/bottom_bar_widget.dart';
import 'package:gvg_order/src/ui/shared/widgets/custom_app_bar_widget.dart';
import 'package:gvg_order/src/ui/shared/widgets/custom_text_field_widget.dart';
import 'package:gvg_order/src/ui/theme/app_colors.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: const CustomAppBar(
        title: 'Payment Page',
        isBasketVisible: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    "Delivery Address",
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    "Street 1, City, Country",
                    style: TextStyle(
                      color: lightTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  PaymentWidget(),
                  const Text(
                    "Order message",
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const CustomTextField(
                    hintText: "Enter your message",
                    maxLines: 5,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: lightGreyColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.gift,
                            color: primaryColor,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Cupons / Campaigns",
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: greyColor,
                            size: 16,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          const BottomBarWidget(),
        ],
      ),
    );
  }
}

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Method",
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        PaymentMethodWidget(
          value: '1',
          groupValue: '1',
          onChanged: (value) {},
          title: 'Credit Card',
        ),
        PaymentMethodWidget(
          value: '2',
          groupValue: '1',
          onChanged: (value) {},
          title: 'Paypal',
        ),
        PaymentMethodWidget(
          value: '3',
          groupValue: '1',
          onChanged: (value) {},
          title: 'Credit Card',
        ),
      ],
    );
  }
}

class PaymentMethodWidget extends StatelessWidget {
  final String value;
  final String groupValue;
  final Function onChanged;
  final String title;
  const PaymentMethodWidget({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      value: value,
      groupValue: groupValue,
      dense: false,
      visualDensity: VisualDensity.compact,
      contentPadding: EdgeInsets.zero,
      onChanged: (value) {},
      activeColor: primaryColor.withOpacity(0.8),
      toggleable: true,
      title: Text(
        title,
        style: const TextStyle(
          color: greyColor,
          fontSize: 16,
        ),
      ),
    );
  }
}
