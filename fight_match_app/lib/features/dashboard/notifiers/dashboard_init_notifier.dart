import '../../../core/utils/navigators.dart';
import '../../posts/notifiers/posts_notifier.dart';
import '../screens/dashboard_screen.dart';
import '../../../models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/auth.dart';
import '../../auth/notifiers/auth_notifier.dart';

class DashboardInitNotifier extends StateNotifier<User?> {
  // final LoaderNotifier _loader;
  final Auth _auth;
  // final Profile _profile;
  final PostsNotifier _posts;
  DashboardInitNotifier({
    // required LoaderNotifier loader,
    required Auth auth,
    // required Profile profile,
    required PostsNotifier posts,
  })  :
        // _loader = loader,
        _auth = auth,
        // _profile = profile,
        _posts = posts,
        super(null);

  // Dont call _profile.getCurrentUserProfile here
  Future<void> initialize(BuildContext context) async {
    await _posts.fetchPostsByProfileId(context: context, userId: _auth.userId);
    if (context.mounted) {
      navigateAndRemoveUntil(context, const DashboardScreen());
    }
    // print("UserId: ${_profile.userId}");
    // print("ProfileId: ${_profile.profileId}");
    // if (_profile.userId!.isNotEmpty && _profile.profileId!.isNotEmpty) {
    //   await _posts.fetchMyPosts(_profile.userId!);
    //   if (context.mounted) {
    //     print("Navigating to DashboardScreen");
    //     navigateAndRemoveUntil(context, const DashboardScreen());
    //   }
    // } else {
    //   print("Profile ID or User ID is missing");
    //   return;
    // }
  }
}
// -----------------------------------------------------------------------------

final dashboardInitProvider =
    StateNotifierProvider<DashboardInitNotifier, User?>((ref) {
  // final loader = ref.read(loaderProvider.notifier);
  final auth = ref.read(authProvider);
  // final profile = ref.read(profileProvider);
  final posts = ref.read(postsProvider.notifier);
  return DashboardInitNotifier(
    // loader: loader,
    auth: auth!,
    // profile: profile!,
    posts: posts,
  );
});
