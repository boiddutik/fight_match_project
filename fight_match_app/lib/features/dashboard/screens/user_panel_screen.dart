import 'package:fight_match_app/features/auth/notifiers/auth_notifier.dart';
import 'package:fight_match_app/features/auth/screens/profile_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import '../../../core/constants/icons.dart';
import '../../../core/constants/palette.dart';
import '../../../core/utils/navigators.dart';
import '../../../core/widgets/custom_regular_app_bar.dart';
import 'edit_profile_screen.dart';

class UserPanelScreen extends ConsumerWidget {
  const UserPanelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(authProvider)!.profile;
    return Scaffold(
      appBar: const CustomRegularAppBar(title: 'Profile'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card.filled(
                elevation: 0,
                color: Palette.textField,
                surfaceTintColor: Palette.textField,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  child: Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(userProfile.avatar),
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
                                    color: Palette.textFieldHeader,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          child: const Text('View Profile'),
                          onPressed: () {
                            navigate(
                                context,
                                ProfileScreen(
                                  user: userProfile,
                                ));
                          },
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
                  child: Icon(CustomIcons.editProfile),
                ),
                title: const Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(CustomIcons.next),
              ),
              ListTile(
                onTap: () {},
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFf8f8f8),
                  child: Icon(CustomIcons.changePassword),
                ),
                title: const Text(
                  'Change Password',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(CustomIcons.next),
              ),
              ListTile(
                onTap: () {},
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFf8f8f8),
                  child: Icon(CustomIcons.helpSupport),
                ),
                title: const Text(
                  'Help & Support',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(CustomIcons.next),
              ),
              ListTile(
                onTap: () {},
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFf8f8f8),
                  child: Icon(CustomIcons.privacyPolicy),
                ),
                title: const Text(
                  'Privacy Policy',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(CustomIcons.next),
              ),
              ListTile(
                onTap: () {},
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFf8f8f8),
                  child: Icon(CustomIcons.rateApp),
                ),
                title: const Text(
                  'Feedback',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(CustomIcons.next),
              ),
              ListTile(
                onTap: () {
                  // ref.read(authProvider.notifier).logout(context);
                },
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFf8f8f8),
                  child: Icon(CustomIcons.signOut),
                ),
                title: const Text(
                  'Sign out',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(CustomIcons.next),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
