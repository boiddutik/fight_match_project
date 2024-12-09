import 'dart:ui';

import 'package:fight_match_app/core/constants/icons.dart';
import 'package:fight_match_app/core/constants/palette.dart';
import 'package:fight_match_app/core/utils/navigators.dart';
import 'package:fight_match_app/features/dashboard/screens/dashboard_init_screen.dart';
import 'package:flutter/material.dart';

Future<void> showPopUpDialog({
  required BuildContext context,
  required String title,
  required IconData iconPath,
  double? iconSize = 40,
  Color? iconColor = Palette.darkGreen,
  String? subTitle,
  List<Widget>? buttons,
}) async {
  showDialog(
    context: context,
    barrierColor: const Color(0xFF617d79).withOpacity(0.2),
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: Palette.white,
                  surfaceTintColor: Palette.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 32),
                    child: Column(
                      children: [
                        Icon(
                          iconPath,
                          size: iconSize,
                          color: iconColor,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontFamily: 'Zen',
                                    color: Palette.darkGreen,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        if (subTitle != null)
                          Text(
                            subTitle,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  fontFamily: 'Zen',
                                ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Button Row
              Column(
                children: buttons ??
                    [
                      Card(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(color: Palette.white)),
                        color: Palette.white,
                        surfaceTintColor: Palette.white,
                        child: ListTile(
                          onTap: () {
                            navigateAndRemoveUntil(
                                context, const DashboardInitScreen());
                          },
                          title: Text(
                            'Explore',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontFamily: 'Zen',
                                      color: Palette.darkGreen,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          trailing: const Icon(CustomIcons.next),
                        ),
                      ),
                      Card(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(color: Palette.white)),
                        color: Palette.white,
                        surfaceTintColor: Palette.white,
                        child: ListTile(
                          onTap: () {
                            navigateAndRemoveUntil(
                                context, const DashboardInitScreen());
                          },
                          title: Text(
                            'Setup Profile',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontFamily: 'Zen',
                                      color: Palette.darkGreen,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          trailing: const Icon(CustomIcons.next),
                        ),
                      ),
                    ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    },
  );
}
