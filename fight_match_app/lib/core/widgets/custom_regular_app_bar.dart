import 'package:fight_match_app/core/constants/icons.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/navigators.dart';
import '../../features/notifications/screens/notification_screen.dart';
import '../../features/search/screens/search_screen.dart';

class CustomRegularAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  const CustomRegularAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          navigate(context, const SearchScreen());
        },
        icon: const Icon(CustomIcons.search),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
      ),
      actions: [
        IconButton(
          onPressed: () {
            navigate(context, const NotificationScreen());
          },
          icon: const Icon(CustomIcons.notifications),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
