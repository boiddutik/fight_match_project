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
              postId: "1",
              postType: PostType.post,
              creatorUserId: "user123",
              creatorUserName: "JohnDoe",
              creatorProfileId: "profile123",
              creatorFullName: "John Doe",
              creatorAvatar:
                  "https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
              privacy: "public",
              caption: "This is a post caption.",
              description: "This is the detailed description of the post.",
              createdAt: DateTime.parse("2024-12-09T05:16:54Z"),
              updatedAt: DateTime.parse("2024-12-09T05:16:54Z"),
              medium: [
                Media(
                  mediaId: "01",
                  mediaType: MediaType.image,
                  mediaDescription: "An image post",
                  mediaUrl:
                      'https://images.pexels.com/photos/2204179/pexels-photo-2204179.jpeg?auto=compress&cs=tinysrgb&w=600',
                  likes: ["user456"],
                  unLikes: ["user789"],
                  comments: ["Nice post!", "Great picture!"],
                  shares: ["user111"],
                  views: ["user123", "user456", "user789"],
                  reports: [],
                ),
              ],
              likes: ["user456", "user789"],
              unLikes: ["user111"],
              comments: ["Nice post!", "I like it!"],
              shares: ["user111"],
              views: ["user123", "user456", "user789"],
              reports: [],
              associates: ["user999"],
              eventVenue: null,
              eventLatitude: null,
              eventLongitude: null,
              eventDate: null,
            ),
            Post(
              postId: "2",
              postType: PostType.highlight,
              creatorUserId: "user123",
              creatorUserName: "JohnDoe",
              creatorProfileId: "profile123",
              creatorFullName: "John Doe",
              creatorAvatar:
                  "https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
              privacy: "public",
              caption: "This is a highlight caption.",
              description: "This is the detailed description of the highlight.",
              createdAt: DateTime.parse("2024-12-09T05:16:54Z"),
              updatedAt: DateTime.parse("2024-12-09T05:16:54Z"),
              medium: [
                Media(
                  mediaId: "02",
                  mediaType: MediaType.video,
                  mediaDescription: "A highlight video",
                  mediaUrl:
                      'https://videos.pexels.com/video-files/5537799/5537799-hd_1920_1080_25fps.mp4',
                  likes: ["user456"],
                  unLikes: ["user789"],
                  comments: ["Amazing!", "So cool!"],
                  shares: ["user222"],
                  views: ["user123", "user456"],
                  reports: [],
                ),
              ],
              likes: ["user456", "user789"],
              unLikes: ["user111"],
              comments: ["Amazing highlight!", "Great work!"],
              shares: ["user222"],
              views: ["user123", "user456"],
              reports: [],
              associates: ["user999"],
              eventVenue: null,
              eventLatitude: null,
              eventLongitude: null,
              eventDate: null,
            ),
            Post(
              postId: "3",
              postType: PostType.event,
              creatorUserId: "user123",
              creatorUserName: "JohnDoe",
              creatorProfileId: "profile123",
              creatorFullName: "John Doe",
              creatorAvatar:
                  "https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
              privacy: "public",
              caption: "This is an event caption.",
              description:
                  "Details of the event, where it's happening and who is invited.",
              createdAt: DateTime.parse("2024-12-09T05:16:54Z"),
              updatedAt: DateTime.parse("2024-12-09T05:16:54Z"),
              medium: [
                Media(
                  mediaId: "03",
                  mediaType: MediaType.image,
                  mediaDescription: "Event image",
                  mediaUrl:
                      'https://images.pexels.com/photos/264279/pexels-photo-264279.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  likes: ["user456"],
                  unLikes: ["user789"],
                  comments: ["Looking forward!", "I will attend!"],
                  shares: ["user333"],
                  views: ["user123", "user456", "user789"],
                  reports: [],
                ),
                Media(
                  mediaId: "04",
                  mediaType: MediaType.video,
                  mediaDescription: "Event promo video",
                  mediaUrl:
                      'https://videos.pexels.com/video-files/3192196/3192196-sd_640_360_25fps.mp4',
                  likes: ["user456", "user789"],
                  unLikes: ["user111"],
                  comments: ["Great video!", "I will be there!"],
                  shares: ["user444"],
                  views: ["user123", "user456", "user789"],
                  reports: [],
                ),
              ],
              likes: ["user456", "user789"],
              unLikes: ["user111"],
              comments: ["Looking forward to it!", "I am going!"],
              shares: ["user333"],
              views: ["user123", "user456", "user789"],
              reports: [],
              associates: ["user999"],
              eventVenue: "123 Main St, SomeCity, Country",
              eventLatitude: 40.7128,
              eventLongitude: -74.0060,
              eventDate: DateTime.parse("2024-12-15T18:00:00Z"),
            ),
            Post(
              postId: "4",
              postType: PostType.reel,
              creatorUserId: "user123",
              creatorUserName: "JohnDoe",
              creatorProfileId: "profile123",
              creatorFullName: "John Doe",
              creatorAvatar:
                  "https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
              privacy: "public",
              caption: "This is a reel caption.",
              description: "This is the detailed description of the reel.",
              createdAt: DateTime.parse("2024-12-09T05:16:54Z"),
              updatedAt: DateTime.parse("2024-12-09T05:16:54Z"),
              medium: [
                Media(
                  mediaId: "07",
                  mediaType: MediaType.video,
                  mediaDescription: "A reel video",
                  mediaUrl:
                      'https://videos.pexels.com/video-files/4830314/4830314-sd_506_960_25fps.mp4',
                  likes: ["user456"],
                  unLikes: ["user789"],
                  comments: ["Awesome reel!", "Nice editing!"],
                  shares: ["user555"],
                  views: ["user123", "user456", "user789"],
                  reports: [],
                ),
              ],
              likes: ["user456", "user789"],
              unLikes: ["user111"],
              comments: ["Nice reel!", "Great job!"],
              shares: ["user555"],
              views: ["user123", "user456", "user789"],
              reports: [],
              associates: ["user999"],
              eventVenue: null,
              eventLatitude: null,
              eventLongitude: null,
              eventDate: null,
            ),
          ],
        );

  /// Creates a new post
  Future<void> createPost({
    required BuildContext context,
    required Post post,
  }) async {
    _loader.setLoadingTo(true);

    final token = _auth.jwt;

    try {
      // // Make API call
      // final result = await _postApi.createPost(
      //   token: token,
      //   privacy: 'Public', // "Public" or "Followers"
      //   title: title,
      //   type: type,
      //   description: description!,
      //   images: images,
      //   videos: videos,
      // );
      // result.match(
      //   (error) {
      //     showSnackbar(context, 'Error: $error');
      //   },
      //   (data) {
      //     final newPost = Post.fromJson(data);
      //     state = [...?state, newPost];
      //     showSnackbar(context, 'Post created successfully!');
      //     _dashboardCounter.changeDashboardCounter(0);
      //   },
      // );
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
