import 'height_screen.dart';
import 'weight_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/svgs.dart';
import '../../../core/utils/navigators.dart';
import '../../../models/user.dart';

class EditProfileScreen extends StatelessWidget {
  final User profile;
  const EditProfileScreen({super.key, required this.profile});

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              // Profile Picture
              Card.filled(
                elevation: 0,
                color: const Color(0xFFf2f2f2),
                surfaceTintColor: const Color(0xFFf2f2f2),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Profile picture',
                            style: TextStyle(
                                color: Color(0xFF303030),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Stack(
                        children: [
                          // CircleAvatar(
                          //   radius: 50,
                          //   backgroundImage: NetworkImage(
                          //       '$baseUrl${profile.profileImageUrl!}'),
                          // ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {},
                              child: SvgPicture.asset(
                                Svgs.indicatorHeightAndWeight,
                                height: 30,
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
                subtitle: profile.fullName,
                onTap: () {
                  // Action for Name Card
                },
              ),
              _buildEditableCard(
                title: 'Profession',
                subtitle: profile.profession,
                onTap: () {
                  // Action for Bio Card
                },
              ),
              _buildEditableCard(
                title: 'Bio',
                subtitle: profile.bio,
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
                subtitle: '0ft',
                onTap: () {
                  navigate(context, const HeightScreen());
                },
              ),
              _buildEditableCard(
                title: 'Weight',
                subtitle: '0 lb',
                onTap: () {
                  navigate(context, const WeightScreen());
                },
              ),
              _buildEditableCard(
                title: 'Location',
                subtitle: '${profile.state} ${profile.country}',
                onTap: () {
                  // Action for Location Card
                },
              ),
              _buildEditableCard(
                title: 'Birthdate',
                subtitle: DateFormat('MMM d, y').format(
                  DateTime.parse(profile.dob.toString()),
                ),
                onTap: () {
                  // Action for Birthdate Card
                },
              ),
              _buildEditableCard(
                title: 'Gender',
                subtitle: profile.gender,
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
        ),
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
        color: const Color(0xFFf2f2f2),
        surfaceTintColor: const Color(0xFFf2f2f2),
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
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
