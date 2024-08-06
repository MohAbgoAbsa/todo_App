import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:untitled/app_colors.dart';
import 'package:untitled/providers/provids.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool blang = false;
  bool bmode = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ChangeProvi>(context);
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.languagedispl,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: AppColors.primaryColor),
              ),
              InkWell(
                onTap: () {
                  if (provider.selectlang == ('en')) {
                    provider.changlang('ar');
                  } else {
                    provider.changlang('en');
                  }
                  setState(() {});
                },
                child: Container(
                  height: 30,
                  width: 70,
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 2, color: const Color(0xff5555ff)),
                      borderRadius: BorderRadius.circular(15),
                      color: provider.selectlang == ('en')
                          ? const Color(0x55737324)
                          : const Color(0xE4D5C00A)),
                  child: Row(
                    mainAxisAlignment: provider.selectlang == ('en')
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                              //border: Border.all(width: 2,color: Color(0xff5555ff)),
                              borderRadius: BorderRadius.circular(15),
                              color: provider.selectlang == ('en')
                                  ? const Color(0x99666666)
                                  : const Color(0xFF1A4C3B)))
                    ],
                  ),
                ),
              )
            ],
          ),

          ///======================================================
          const SizedBox(
            height: 20,
          ),

          ///======================================================

          Text(
            AppLocalizations.of(context)!.mode,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.modetheme,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: AppColors.primaryColor,
                    ),
              ),
              InkWell(
                onTap: () {
                  if (provider.themeMode == ThemeMode.light) {
                    provider.changmode(ThemeMode.dark);
                  } else {
                    provider.changmode(ThemeMode.light);
                  }
                  setState(() {});
                },
                child: Container(
                  height: 30,
                  width: 70,
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 2, color: const Color(0xff5555ff)),
                      borderRadius: BorderRadius.circular(15),
                      color: provider.themeMode == ThemeMode.light
                          ? const Color(0x55737324)
                          : const Color(0xE4D5C00A)),
                  child: Row(
                    mainAxisAlignment: provider.themeMode == ThemeMode.light
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                              //border: Border.all(width: 2,color: Color(0xff5555ff)),
                              borderRadius: BorderRadius.circular(15),
                              color: provider.themeMode == ThemeMode.light
                                  ? const Color(0x99666666)
                                  : const Color(0xFF1A4C3B)))
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
