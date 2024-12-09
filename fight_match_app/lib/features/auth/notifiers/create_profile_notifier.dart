import 'dart:io';

import 'package:fight_match_app/core/utils/navigators.dart';
import 'package:fight_match_app/core/utils/username_generator.dart';
import 'package:fight_match_app/features/auth/notifiers/auth_notifier.dart';
import 'package:fight_match_app/features/auth/screens/create_profile_avatar_screen.dart';
import 'package:fight_match_app/features/auth/screens/create_profile_dob_screen.dart';
import 'package:fight_match_app/features/auth/screens/create_profile_location_screen.dart';
import 'package:fight_match_app/features/auth/screens/create_profile_zip_screen.dart';
import 'package:fight_match_app/features/dashboard/screens/dashboard_init_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/create_profile_gender_screen.dart';
import '../screens/create_profile_name_screen.dart';

class CreateProfileData {
  final String? email;
  final String? password;
  final String? fullName;
  final String? gender;
  final DateTime? dob;
  final String? country;
  final String? zip;
  final File? avatar;

  CreateProfileData({
    this.email,
    this.password,
    this.fullName,
    this.gender,
    this.dob,
    this.country,
    this.zip,
    this.avatar,
  });

  // CopyWith method
  CreateProfileData copyWith({
    String? email,
    String? password,
    String? fullName,
    String? gender,
    DateTime? dob,
    String? country,
    String? zip,
    File? avatar,
  }) {
    return CreateProfileData(
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      country: country ?? this.country,
      zip: zip ?? this.zip,
      avatar: avatar ?? this.avatar,
    );
  }

  // toString method
  @override
  String toString() {
    return 'CreateProfileData(email: $email, password: $password, fullName: $fullName, gender: $gender, dob: $dob, country: $country, zip: $zip, avatar: $avatar)';
  }
}

class CreateProfileNotifier extends StateNotifier<CreateProfileData> {
  final AuthNotifier _auth;
  CreateProfileNotifier({required AuthNotifier auth})
      : _auth = auth,
        super(CreateProfileData());

  void addEmailandPassword(
      BuildContext context, String email, String password) {
    state = state.copyWith(email: email, password: password);
    navigate(context, const CreateProfileNameScreen());
  }

  void addFullname(BuildContext context, String fullName) {
    state = state.copyWith(fullName: fullName);
    navigate(context, const CreateProfileGenderScreen());
  }

  void addGender(BuildContext context, String gender) {
    state = state.copyWith(gender: gender);
    navigate(context, const CreateProfileDobScreen());
  }

  void addDob(BuildContext context, DateTime dob) {
    state = state.copyWith(dob: dob);
    navigate(context, const CreateProfileLocationScreen());
  }

  void addLocation(BuildContext context, String country) {
    state = state.copyWith(country: country);
    navigate(context, const CreateProfileZipScreen());
  }

  void addZip(BuildContext context, String zip) {
    state = state.copyWith(zip: zip);
    navigate(context, const CreateProfileAvatarScreen());
  }

  void addAvatar(BuildContext context, File avatar) {
    // state = state.copyWith(avatar: avatar);
    // _auth.createUser(
    //   context: context,
    //   email: state.email!,
    //   password: state.password!,
    //   profession: '...',
    //   fullName: state.fullName!,
    //   gender: state.gender!,
    //   country: state.country!,
    //   geoState: '...',
    //   city: '...',
    //   dob: state.dob!,
    //   avatar: avatar,
    //   cover: null,
    //   userName: generateUsername(state.email!),
    // );
    navigateAndRemoveUntil(context, const DashboardInitScreen());
  }
}
// -----------------------------------------------------------------------------

final createProfileProvider =
    StateNotifierProvider<CreateProfileNotifier, CreateProfileData>((ref) {
  final auth = ref.read(authProvider.notifier);
  return CreateProfileNotifier(auth: auth);
});
