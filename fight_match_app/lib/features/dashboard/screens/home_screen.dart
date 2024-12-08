import 'package:fight_match_app/core/constants/icons.dart';
import 'package:fight_match_app/features/auth/notifiers/auth_notifier.dart';
import 'package:fight_match_app/features/posts/notifiers/posts_notifier.dart';
import 'package:fight_match_app/features/posts/widgets/post_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/palette.dart';
import '../../../core/utils/navigators.dart';
import 'notification_screen.dart';
import 'search_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postsProvider);
    int? profileCompletionPersentage =
        ref.watch(authProvider.notifier).getProfileCompletionPercentage();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              navigate(context, const SearchScreen());
            },
            icon: const Icon(CustomIcons.search)),
        title: const Text(
          'FIghtMatch',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: () {
                navigate(context, const NotificationScreen());
              },
              icon: const Icon(CustomIcons.notifications)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: posts == null
            // ignore: prefer_const_constructors
            ? SizedBox.shrink()
            : ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return PostCard(post: post);
                },
              ),
      ),
      bottomNavigationBar: profileCompletionPersentage == null
          ? SizedBox.shrink()
          : AspectRatio(
              aspectRatio: 16 / 3,
              child: Container(
                color: Palette.textField,
                child: ListTile(
                  title: Text(
                      'Your profile is $profileCompletionPersentage% complete.'),
                  subtitle: FittedBox(
                    child: Text(
                      'For best matches, please complete your profile.',
                    ),
                  ),
                  trailing: CircleAvatar(
                    backgroundColor: Palette.liteBlack,
                    child: Icon(
                      CustomIcons.next,
                      color: Palette.white,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
