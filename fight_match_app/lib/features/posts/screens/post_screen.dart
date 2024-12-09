import 'dart:io';
import 'package:fight_match_app/core/constants/icons.dart';
import 'package:fight_match_app/core/constants/palette.dart';
import 'package:fight_match_app/features/auth/notifiers/auth_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:video_player/video_player.dart';
import '../../../core/notifiers/loader_notifier.dart';
import '../../../core/utils/pickers.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/snackbar.dart';
import '../notifiers/posts_notifier.dart';

class PostScreen extends ConsumerStatefulWidget {
  const PostScreen({super.key});

  @override
  ConsumerState<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  final _captionController = TextEditingController();
  File? _pickedCameraItem;
  List<File>? _pickedGalleryItems;
  VideoPlayerController? _videoPlayerController;

  @override
  void dispose() {
    _captionController.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  void _pickCamera() async {
    _pickedGalleryItems = null;
    File? image = await openCamera();
    if (image != null) {
      setState(() {
        _pickedCameraItem = image;
      });
    }
  }

  void _pickGallery() async {
    _pickedCameraItem = null;
    List<File>? pickedFiles = await openGallery();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        _pickedGalleryItems = pickedFiles;
      });
    }
  }

  bool isImage(String path) {
    final ext = path.split('.').last.toLowerCase();
    return ext == 'jpg' || ext == 'jpeg' || ext == 'png' || ext == 'gif';
  }

  // Function to create the post
  Future<void> createPost() async {
    final caption = _captionController.text.trim();

    // Validation
    if (caption.isEmpty) {
      showSnackbar(context, 'Please add a thought to proceed!');
      return;
    }

    // Separate the files into images and videos
    List<File> imageFiles = [];
    List<File> videoFiles = [];

    // Check if picked items are images or videos and add them to appropriate lists
    if (_pickedCameraItem != null) {
      if (isImage(_pickedCameraItem!.path)) {
        imageFiles.add(_pickedCameraItem!);
      } else {
        videoFiles.add(_pickedCameraItem!);
      }
    }

    if (_pickedGalleryItems != null) {
      for (var file in _pickedGalleryItems!) {
        if (isImage(file.path)) {
          imageFiles.add(file);
        } else {
          videoFiles.add(file);
        }
      }
    }

    // Call the API function to create the post
    await ref.read(postsProvider.notifier).createPost(
          context: context,
          title: caption,
          type: 'Post',
          description: '',
          images: imageFiles,
          videos: videoFiles,
        );
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.read(authProvider)!.profile;
    final isLoading = ref.watch(loaderProvider);

    return Skeletonizer(
      enabled: isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            'Create Post',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 10, bottom: 10),
              child: SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    createPost();
                  },
                  child: const Text('Post'),
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(userProfile.avatar),
                        ),
                        title: Text(
                          userProfile.fullName,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_vert)),
                      ),
                      ListTile(
                        title: TextField(
                          controller: _captionController,
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus!.unfocus();
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Share your thoughts',
                          ),
                          maxLines: 4,
                        ),
                      ),
                    ],
                  ),
                  if (_pickedCameraItem != null ||
                      (_pickedGalleryItems != null &&
                          _pickedGalleryItems!.isNotEmpty))
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 1.0,
                        ),
                        itemCount: _pickedGalleryItems != null
                            ? _pickedGalleryItems!.length +
                                (_pickedCameraItem != null ? 1 : 0)
                            : (_pickedCameraItem != null ? 1 : 0),
                        itemBuilder: (context, index) {
                          // Determine which media to show
                          File media;
                          if (_pickedCameraItem != null && index == 0) {
                            media = _pickedCameraItem!;
                          } else {
                            media = _pickedGalleryItems![
                                index - (_pickedCameraItem != null ? 1 : 0)];
                          }

                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: isImage(media.path)
                                ? Image.file(
                                    media,
                                    fit: BoxFit.cover,
                                  )
                                : GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      color: Colors.black,
                                      child: const Center(
                                        child: Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.2,
              minChildSize: 0.06,
              maxChildSize: 0.42,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Palette.textField, width: 2),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 150, right: 150, top: 16),
                        child: Container(
                          height: 5,
                          width: 40,
                          margin: const EdgeInsets.only(bottom: 8.0),
                          decoration: BoxDecoration(
                            color: Palette.textField,
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: const Icon(CustomIcons.highlights),
                        title: const Text(
                          'Highlights',
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: const Icon(CustomIcons.photosVideos),
                        title: const Text(
                          'Photo / Video',
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: const Icon(CustomIcons.events),
                        title: const Text(
                          'Event',
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: const Icon(CustomIcons.reels),
                        title: const Text(
                          'Reels',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
