import 'package:fight_match_app/features/dashboard/notifiers/dashboard_notifier.dart';
import 'package:fight_match_app/features/posts/screens/post_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/icons.dart';
import 'home_screen.dart';
import 'inbox_screen.dart';
import 'match_screen.dart';
import 'package:flutter/material.dart';

import 'profile_screen.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final screens = const [
    HomeScreen(),
    MatchScreen(),
    PostScreen(),
    InboxScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    int bottomNavBarIndex = ref.watch(dashboardCounterProvider);
    final dashboardCounterNotifier =
        ref.read(dashboardCounterProvider.notifier);
    return Scaffold(
      body: screens[bottomNavBarIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavBarIndex,
        onTap: (value) {
          dashboardCounterNotifier.changeDashboardCounter(value);
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'WorkSans',
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedItemColor: const Color(0xFF646464),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'WorkSans',
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              label: 'Home',
              icon: Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Icon(
                  CustomIcons.home,
                  size: 25,
                ),
              )),
          BottomNavigationBarItem(
              label: 'Match',
              icon: Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Icon(
                  CustomIcons.explore,
                  size: 25,
                ),
              )),
          BottomNavigationBarItem(
              label: '',
              icon: Icon(
                CustomIcons.addPost,
                size: 40,
              )),
          BottomNavigationBarItem(
              label: 'Inbox',
              icon: Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Icon(
                  CustomIcons.inbox,
                  size: 25,
                ),
              )),
          BottomNavigationBarItem(
              label: 'Profile',
              icon: Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Icon(
                  CustomIcons.profile,
                  size: 25,
                ),
              )),
        ],
      ),
    );
  }
}
