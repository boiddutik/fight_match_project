import 'notification_screen.dart';
import 'search_screen.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/navigators.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              navigate(context, const SearchScreen());
            },
            icon: const Icon(Icons.search)),
        title: const Text(
          'Match',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: () {
                navigate(context, const NotificationScreen());
              },
              icon: const Icon(Icons.notifications)),
        ],
      ),
    );
  }
}
