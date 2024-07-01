import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/language/language_controller.dart';
import '../shared/widgets/custom_dialog_widget.dart';
import '../theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageDialog extends GetWidget<LanguageController> {
  const LanguageDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialogWidget(
      height: Get.height * 0.4,
      children: [
        const SizedBox(
          height: 12,
        ),
        Text(
          AppLocalizations.of(context)!.selectlanguage,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: const [
              LanguageWidget(
                title: 'English',
                locale: 'en',
              ),
              SizedBox(
                height: 12,
              ),
              LanguageWidget(
                title: 'Türkçe',
                locale: 'tr',
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ElevatedButton(
            onPressed: () {
              controller.setLanguage();
            },
            child: Text(AppLocalizations.of(context)!.restartapp),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class LanguageWidget extends GetWidget<LanguageController> {
  const LanguageWidget({
    super.key,
    required this.title,
    required this.locale,
  });
  final String title;
  final String locale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Obx(
        () {
          return RadioListTile(
            groupValue: controller.selectedLanguage.value,
            value: locale,
            onChanged: (value) {
              if (value != null) controller.selectedLanguage.value = value;
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                color: lightGreyColor,
              ),
            ),
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: greyColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
