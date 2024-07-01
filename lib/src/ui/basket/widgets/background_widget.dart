import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gvg_order/src/ui/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BasketBackgroundWidget extends StatelessWidget {
  const BasketBackgroundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: redColor.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.delete,
                color: redColor,
              ),
              Text(
                AppLocalizations.of(context)!.delete,
                style: const TextStyle(
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
