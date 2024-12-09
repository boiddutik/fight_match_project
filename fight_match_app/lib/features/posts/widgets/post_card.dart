import 'package:fight_match_app/features/posts/widgets/post_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_time_ago/get_time_ago.dart';

import '../../../core/constants/icons.dart';
import '../../../models/media.dart';
import '../../../models/post.dart';

class PostCard extends ConsumerWidget {
  final Post post;
  const PostCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card.outlined(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Header
            ListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(post.creatorAvatar),
              ),
              title: Text(
                post.creatorFullName,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Row(
                children: [
                  Text(
                    GetTimeAgo.parse(post.createdAt!),
                    style:
                        const TextStyle(fontSize: 12, color: Color(0xFFcccccc)),
                  ),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          '●',
                          style:
                              TextStyle(fontSize: 8, color: Color(0xFFcccccc)),
                        ),
                      ),
                      Text(
                        'Follow',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: const Icon(Icons.more_vert),
            ),
            // Body
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        post.caption,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  AspectRatio(
                    aspectRatio:
                        post.postType == PostType.reel ? 9 / 16 : 16 / 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CarouselView(
                        itemExtent: double.infinity,
                        children: post.medium!.map<Widget>((media) {
                          if (media.mediaType == MediaType.image) {
                            return Image.network(
                              media.mediaUrl!,
                              fit: BoxFit.cover,
                            );
                          } else {
                            return PostVideoPlayer(
                              videoUrl: media.mediaUrl!,
                              postType: post.postType,
                            );
                          }
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Footer
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Column(
                children: [
                  const ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    title: Row(
                      children: [
                        Icon(CustomIcons.like),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: Icon(CustomIcons.comment),
                        ),
                        Icon(CustomIcons.share),
                      ],
                    ),
                    trailing: Icon(CustomIcons.bookmark),
                  ),
                  Row(
                    children: [
                      Text(
                        '${post.likes!.length} Likes',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          '●',
                          style:
                              TextStyle(fontSize: 8, color: Color(0xFFcccccc)),
                        ),
                      ),
                      Text(
                        '${post.comments!.length} comments',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          '●',
                          style:
                              TextStyle(fontSize: 8, color: Color(0xFFcccccc)),
                        ),
                      ),
                      Text(
                        '${post.shares!.length} shares',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
