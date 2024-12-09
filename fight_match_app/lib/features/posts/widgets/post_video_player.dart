import 'package:fight_match_app/models/post.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PostVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final PostType postType;

  const PostVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.postType,
  });

  @override
  PostVideoPlayerState createState() => PostVideoPlayerState();
}

class PostVideoPlayerState extends State<PostVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then(
        (_) {
          setState(() {});
        },
      );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.postType == PostType.reel
          ? 9 / 16
          : _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    );
  }
}
