import 'dart:io';

import '../../../core/constants/icons.dart';
import '../../../core/constants/palette.dart';
import '../../../core/utils/pickers.dart';
import 'edit_profile_screens/height_screen.dart';
import 'edit_profile_screens/weight_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/svgs.dart';
import '../../../core/utils/navigators.dart';
import '../../../models/user.dart';

class EditProfileScreen extends StatefulWidget {
  final User profile;
  const EditProfileScreen({super.key, required this.profile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _selectedAvatar;
  File? _selectedCover;

  Future<void> onPickCover() async {
    File? image = await openGalleryLegacy();
    if (image != null) {
      setState(() {
        _selectedCover = image;
      });
    }
  }

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SvgPicture.asset(Svgs.backButton),
          ),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
      body: ListView(
        children: [
          // Profile Picture
          Card.filled(
            elevation: 0,
            color: Palette.textField,
            surfaceTintColor: Palette.textField,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Cover & Avater',
                        style: TextStyle(
                            color: Color(0xFF303030),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Stack(
                  //   children: [
                  //     CircleAvatar(
                  //       radius: 50,
                  //       backgroundImage: NetworkImage(profile.avatar),
                  //     ),
                  //     Positioned(
                  //       bottom: 0,
                  //       right: 0,
                  //       child: GestureDetector(
                  //         onTap: () {
                  //           // Handle profile picture update
                  //         },
                  //         child: SvgPicture.asset(
                  //           Svgs.indicatorHeightAndWeight,
                  //           height: 30,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: GestureDetector(
                          onTap: onPickCover,
                          child: Card(
                            elevation: 0,
                            color: Palette.textField,
                            surfaceTintColor: Palette.textField,
                            child: _selectedCover != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      _selectedCover!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : widget.profile.cover.isEmpty
                                    ? const Center(
                                        child: Icon(CustomIcons.cover),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          widget.profile.cover,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: GestureDetector(
                          onTap: onPickAvatar,
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Card(
                              elevation: 5,
                              color: Palette.textField,
                              surfaceTintColor: Palette.textField,
                              child: _selectedAvatar != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.file(
                                        _selectedAvatar!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : widget.profile.avatar.isEmpty
                                      ? const Center(
                                          child: Icon(CustomIcons.cover),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                            widget.profile.avatar,
                                            fit: BoxFit.cover,
                                          ),
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
          // Editable Cards
          _buildEditableCard(
            title: 'Name',
            subtitle: widget.profile.fullName,
            onTap: () {
              // Action for Name Card
            },
          ),
          _buildEditableCard(
            title: 'Profession',
            subtitle: widget.profile.profession,
            onTap: () {
              // Action for Bio Card
            },
          ),
          _buildEditableCard(
            title: 'Bio',
            subtitle: widget.profile.bio,
            onTap: () {
              // Action for Bio Card
            },
          ),
          _buildEditableCard(
            title: 'Wallet',
            subtitle: '#cashapp',
            onTap: () {
              // Action for Wallet Card
            },
          ),
          _buildEditableCard(
            title: 'Sponsors',
            subtitle: 'CocaCola, FedEx',
            onTap: () {
              // Action for Sponsors Card
            },
          ),
          _buildEditableCard(
            title: 'Height',
            subtitle: '0ft', // You may need to show actual height here
            onTap: () {
              navigate(context, const HeightScreen());
            },
          ),
          _buildEditableCard(
            title: 'Weight',
            subtitle: '0 lb', // You may need to show actual weight here
            onTap: () {
              navigate(context, const WeightScreen());
            },
          ),
          _buildEditableCard(
            title: 'Location',
            subtitle:
                '${widget.profile.city}, ${widget.profile.state}, ${widget.profile.country}',
            onTap: () {
              // Action for Location Card
            },
          ),
          _buildEditableCard(
            title: 'Birthdate',
            subtitle: DateFormat('MMM d, y').format(
              DateTime.parse(widget.profile.dob.toString()),
            ),
            onTap: () {
              // Action for Birthdate Card
            },
          ),
          _buildEditableCard(
            title: 'Gender',
            subtitle: widget.profile.gender,
            onTap: () {
              // Action for Gender Card
            },
          ),
          _buildEditableCard(
            title: 'Goal',
            subtitle: 'learn self-defense',
            onTap: () {
              // Action for Goal Card
            },
          ),
          _buildEditableCard(
            title: 'Intensity level',
            subtitle: 'Semi-Contact Competitive',
            onTap: () {
              // Action for Intensity Level Card
            },
          ),
          _buildEditableCard(
            title: 'Currently practising',
            subtitle: 'Judo',
            onTap: () {
              // Action for Currently Practising Card
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // A helper function to build an editable card
  Widget _buildEditableCard({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card.filled(
        elevation: 0,
        color: Palette.textField,
        surfaceTintColor: Palette.textField,
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF303030),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const Icon(CustomIcons.next),
        ),
      ),
    );
  }
}
