import 'dart:io';

import 'package:fight_match_app/core/notifiers/loader_notifier.dart';
import 'package:fight_match_app/features/auth/notifiers/auth_notifier.dart';
import 'package:fight_match_app/features/dashboard/notifiers/dashboard_notifier.dart';
import 'package:fight_match_app/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/snackbar.dart';
import '../../../models/auth.dart';
import '../../../repositories/remote/post_api.dart';

class PostsNotifier extends StateNotifier<List<Post>?> {
  final LoaderNotifier _loader;
  final Auth _auth;
  final PostApi _postApi;
  final DashboardCounterNotifier _dashboardCounter;
  PostsNotifier({
    required LoaderNotifier loader,
    required Auth auth,
    required PostApi postApi,
    required DashboardCounterNotifier dashboardCounter,
  })  : _loader = loader,
        _auth = auth,
        _postApi = postApi,
        _dashboardCounter = dashboardCounter,
        super(
          [
            Post(
              id: "postId123",
              userId: '11233444',
              userName: 'dummyJoe',
              userFullName: 'John Doe',
              userAvatar:
                  'https://images.pexels.com/photos/7045755/pexels-photo-7045755.jpeg?auto=compress&cs=tinysrgb&w=600',
              privacy: "Public",
              title: "My First Post",
              description: "This is a dummy post created for testing purposes.",
              images: [
                'https://images.pexels.com/photos/2204179/pexels-photo-2204179.jpeg?auto=compress&cs=tinysrgb&w=600',
                'https://images.pexels.com/photos/2204182/pexels-photo-2204182.jpeg?auto=compress&cs=tinysrgb&w=600',
              ],
              videos: [
                'https://videos.pexels.com/video-files/6765232/6765232-sd_640_360_25fps.mp4'
              ],
              comments: ["comment1", "comment2", "comment3"],
              likes: ["like1", "like2", "like3", "like4", "like5"],
              unLikes: ["unlike1", "unlike2"],
              shares: ["share1", "share2", "share3", "share4"],
              views: ["view1", "view2", "view3", "view4", "view5", "view6"],
              reports: ["report1"],
              createdAt: DateTime.now()
                  .subtract(const Duration(days: 1))
                  .toIso8601String(),
              updatedAt: DateTime.now().toIso8601String(),
            ),
          ],
        );

  /// Creates a new post
  Future<void> createPost({
    required BuildContext context,
    required String title,
    required String type,
    String? description,
    List<File>? images,
    List<File>? videos,
  }) async {
    _loader.setLoadingTo(true);

    final token = _auth.jwt;

    try {
      // Make API call
      final result = await _postApi.createPost(
        token: token,
        privacy: 'Public', // "Public" or "Followers"
        title: title,
        type: type,
        description: description!,
        images: images,
        videos: videos,
      );

      result.match(
        (error) {
          showSnackbar(context, 'Error: $error');
        },
        (data) {
          final newPost = Post.fromJson(data);
          state = [...?state, newPost];
          showSnackbar(context, 'Post created successfully!');
          _dashboardCounter.changeDashboardCounter(0);
        },
      );
    } catch (error) {
      if (context.mounted) {
        showSnackbar(context, 'An unexpected error occurred: $error');
      }
    } finally {
      _loader.setLoadingTo(false);
    }
  }

  Future<void> fetchPostsByProfileId({
    required BuildContext context,
    required String userId,
  }) async {
    _loader.setLoadingTo(true);
    final token = _auth.jwt;

    try {
      // Fetch the posts using the PostApi method
      final result =
          await _postApi.getPostsByProfileId(token: token, userId: userId);

      result.match(
        (error) {
          showSnackbar(context, 'Error: $error');
        },
        (data) {
          state = data;
          showSnackbar(context, 'Posts fetched successfully!');
        },
      );
    } catch (error) {
      if (context.mounted) {
        showSnackbar(context, 'An unexpected error occurred: $error');
      }
    } finally {
      _loader.setLoadingTo(false);
    }
  }
}

// -----------------------------------------------------------------------------

final postsProvider = StateNotifierProvider<PostsNotifier, List<Post>?>((ref) {
  final loader = ref.read(loaderProvider.notifier);
  final auth = ref.read(authProvider);
  final postApi = ref.read(postApiProvider);
  final dashboardCounter = ref.read(dashboardCounterProvider.notifier);
  return PostsNotifier(
    loader: loader,
    auth: auth!,
    postApi: postApi,
    dashboardCounter: dashboardCounter,
  );
});
