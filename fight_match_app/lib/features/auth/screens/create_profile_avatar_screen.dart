import 'dart:io';

import 'package:fight_match_app/core/constants/palette.dart';
import 'package:fight_match_app/core/constants/svgs.dart';
import 'package:fight_match_app/core/notifiers/loader_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/constants/icons.dart';
import '../../../core/utils/pickers.dart';
import '../../../core/utils/snackbar.dart';
import '../notifiers/create_profile_notifier.dart';
import '../widgets/auth_field.dart';

class CreateProfileAvatarScreen extends ConsumerStatefulWidget {
  const CreateProfileAvatarScreen({super.key});

  @override
  ConsumerState<CreateProfileAvatarScreen> createState() =>
      _CreateProfileAvatarScreenState();
}

class _CreateProfileAvatarScreenState
    extends ConsumerState<CreateProfileAvatarScreen> {
  File? _selectedAvatar;

  Future<void> onPickAvatar() async {
    File? image = await openGalleryLegacy();
    if (image != null) {
      setState(() {
        _selectedAvatar = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loaderProvider);
    return Skeletonizer(
      enabled: isLoading,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset(Svgs.backButton),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 36),
                    child: Text(
                      'Add Profile Photo',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Palette.darkGreen),
                    ),
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: onPickAvatar,
                        child: CircleAvatar(
                          backgroundColor: Palette.textField,
                          radius: 120,
                          child: _selectedAvatar == null
                              ? const Center(
                                  child: Icon(
                                    CustomIcons.avatar,
                                    size: 150,
                                    color: Palette.darkGreen,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(150),
                                  child: Image.file(
                                    _selectedAvatar!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: onPickAvatar,
                          child: CircleAvatar(
                            backgroundColor:
                                Palette.textFieldHeader.withOpacity(0.4),
                            radius: 30,
                            child: const Center(
                              child: Icon(
                                CustomIcons.camera,
                                size: 30,
                                color: Palette.darkGreen,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        persistentFooterAlignment: AlignmentDirectional.center,
        persistentFooterButtons: [
          GestureDetector(
            onTap: () {
              final avatar = _selectedAvatar;

              if (_selectedAvatar == null) {
                showSnackbar(context, 'Please add your photo!');
                return;
              }
              ref
                  .read(createProfileProvider.notifier)
                  .addAvatar(context, _selectedAvatar!);
            },
            child: SvgPicture.asset(Svgs.go),
          ),
        ],
      ),
    );
  }
}
