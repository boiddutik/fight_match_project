import 'package:fight_match_app/features/auth/notifiers/auth_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import '../../../core/utils/navigators.dart';
import '../../../repositories/base_url.dart';
import '../../dashboard/screens/notification_screen.dart';
import '../../dashboard/screens/search_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(authProvider)!.profile;
    // final userProfileNotifier = ref.read(profileProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              navigate(context, const SearchScreen());
            },
            icon: const Icon(Icons.search)),
        title: const Text(
          'Profile',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card.filled(
                elevation: 0,
                color: const Color(0xFFededed),
                surfaceTintColor: const Color(0xFFededed),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  child: Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage('$baseUrl${userProfile.avatar}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              FittedBox(
                                child: Text(
                                  userProfile.fullName,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                  ),
                                ),
                              ),
                              FittedBox(
                                child: Text(
                                  userProfile.profession,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color(0xFF5f5f5f),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          child: const Text('View Profile'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // ------------------
              const SizedBox(height: 20),
              // ------------------
              ListTile(
                onTap: () {
                  navigate(
                      context,
                      EditProfileScreen(
                        profile: userProfile,
                      ));
                },
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFf8f8f8),
                  child: Icon(Icons.search),
                ),
                title: const Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(Icons.search),
              ),
              ListTile(
                onTap: () {},
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFf8f8f8),
                  child: Icon(Icons.search),
                ),
                title: const Text(
                  'Change Password',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(Icons.search),
              ),
              ListTile(
                onTap: () {},
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFf8f8f8),
                  child: Icon(Icons.search),
                ),
                title: const Text(
                  'Help & Support',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(Icons.search),
              ),
              ListTile(
                onTap: () {},
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFf8f8f8),
                  child: Icon(Icons.search),
                ),
                title: const Text(
                  'Privacy Policy',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(Icons.search),
              ),
              ListTile(
                onTap: () {},
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFf8f8f8),
                  child: Icon(Icons.search),
                ),
                title: const Text(
                  'Feedback',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(Icons.search),
              ),
              ListTile(
                onTap: () {
                  // ref.read(authProvider.notifier).logout(context);
                },
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFf8f8f8),
                  child: Icon(Icons.search),
                ),
                title: const Text(
                  'Sign out',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(Icons.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
