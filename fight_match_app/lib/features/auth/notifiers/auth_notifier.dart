import 'dart:io';

import 'package:fight_match_app/core/notifiers/loader_notifier.dart';
import 'package:fight_match_app/core/utils/navigators.dart';
import 'package:fight_match_app/core/utils/snackbar.dart';
import 'package:fight_match_app/core/utils/username_generator.dart';
import 'package:fight_match_app/features/auth/screens/auth_screen.dart';
import 'package:fight_match_app/features/auth/screens/login_screen.dart';
import 'package:fight_match_app/models/auth.dart';
import 'package:fight_match_app/repositories/remote/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/user.dart';
import '../../../repositories/local/secure_storage_service.dart';
import '../../dashboard/screens/dashboard_init_screen.dart';

class AuthNotifier extends StateNotifier<Auth?> {
  final LoaderNotifier _loader;
  final AuthApi _authApi;

  AuthNotifier({required LoaderNotifier loader, required AuthApi authApi})
      : _loader = loader,
        _authApi = authApi,
        super(
          Auth(
            userId: "dummyUserId123",
            userName: "dummyUser",
            email: "dummy@example.com",
            jwt: "dummyJwtToken",
            rwt: "dummyRefreshToken",
            profile: User(
              id: "mikeTyson123",
              userName: "IronMike",
              email: "miketyson@example.com",
              fullName: "Mike Tyson",
              gender: "Male",
              dob: DateTime(1966, 6, 30), // Mike Tyson's real birthday
              country: "United States",
              state: "Nevada",
              city: "Las Vegas",
              profession: "Professional Boxer",
              bio:
                  "Former undisputed heavyweight champion, also known as 'The Baddest Man on the Planet.'",
              avatar:
                  'https://upload.wikimedia.org/wikipedia/commons/e/ee/Mike_Tyson_Photo_Op_GalaxyCon_Austin_2023.jpg',
              cover:
                  'https://a2.espncdn.com/combiner/i?img=%2Fphoto%2F2024%2F0307%2Fr1301595_1296x729_16%2D9.jpg',
              height: 178.0, // Tyson's height in cm
              weight: 100.0, // Approximate weight in kg
              intensity: "Extreme",
              goal: "Dominate the ring",
              practicing: "Boxing",
              conversations: ["convMike1", "convMike2"],
              posts: ["postMike1", "postMike2"],
              pinnedPosts: ["pinnedMike1"],
              likedPosts: ["likedMike1", "likedMike2"],
              unLikedPosts: ["unlikedMike1"],
              commentedPosts: ["commentMike1"],
              sharedPosts: ["sharedMike1"],
              sentFollowRequests: ["userChampion1"],
              receivedFollowRequests: ["userFan1"],
              followers: ["userFan2", "userFan3"],
              following: ["userLegend1", "userLegend2"],
              blockList: ["blockedMike1"],
              isOnline: true,
              lastOnlineAt: DateTime.now().subtract(Duration(minutes: 30)),
              lastOnlineAtVisible: true,
              activityCount: 120,
              isPrivateProfile: false,
              isProfileMatchable: true,
              wallets: ["walletMike1"],
              sponsors: ["sponsorMike1"],
              fights: ["fightLegend1", "fightLegend2"],
              achievements: ["WBC Champion", "WBA Champion", "IBF Champion"],
              refreshToken: "mikeTysonRefreshToken",
              createdAt: DateTime.now().subtract(
                  Duration(days: 365 * 20)), // Approximate account age
              updatedAt: DateTime.now(),
            ),
          ),
        );

  int? getProfileCompletionPercentage() {
    int totalFields = 0;
    int filledFields = 0;
    final userFields = state!.profile.toJson();
    totalFields = userFields.length;
    userFields.forEach((key, value) {
      if (value is List) {
        if (value.isNotEmpty) filledFields++;
      } else if (value != null && value.toString().isNotEmpty) {
        filledFields++;
      }
    });
    int completionPercentage = ((filledFields / totalFields) * 100).toInt();
    if (completionPercentage > 60) {
      return null;
    }
    return completionPercentage;
  }

  Future<void> createUser({
    required BuildContext context,
    required String email,
    required String password,
    required String profession,
    required String fullName,
    required String gender,
    required String country,
    required String geoState,
    required String city,
    required DateTime dob,
    required File avatar,
    required File? cover,
    String? userName,
  }) async {
    _loader.setLoadingTo(true);
    final username = userName ?? generateUsername(email);
    try {
      final userCreationResult = await _authApi.createUser(
        userName: username,
        email: email,
        password: password,
        fullName: fullName,
        dob: dob.toIso8601String(),
        profession: profession,
        avatar: avatar,
        gender: gender,
        country: country,
        state: geoState,
        city: city,
        cover: cover,
      );
      userCreationResult.fold(
        (error) {
          showSnackbar(context, 'Error: $error');
        },
        (response) {
          showSnackbar(context, 'Account created successfully!');

          navigate(
              context,
              LoginScreen(
                email: email,
              ));
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

  Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    _loader.setLoadingTo(true);

    try {
      final loginResult = await _authApi.loginUser(
        email: email,
        password: password,
      );

      loginResult.fold(
        (error) {
          showSnackbar(context, 'Error: $error');
          if (context.mounted) {
            navigateAndRemoveUntil(context, const AuthScreen());
          }
        },
        (response) async {
          // showSnackbar(context, 'Login successful!');
          final userId = response.data!['_id'];
          // final profileId = response.profile!['_id'];
          final jwt = response.jwt!;
          final rwt = response.rwt!;
          await SecureStorageService().saveUserCredentials(
            email,
            password,
            userId,
            // profileId,
            jwt,
            rwt,
          );
          // Create an Auth object and update the state
          final auth = Auth(
            userId: userId,
            userName: response.data!['userName'],
            email: email,
            jwt: jwt,
            rwt: rwt,
            profile: User.fromJson(response.data!),
          );
          state = auth;
          // print(state!.profile);
          if (context.mounted) {
            navigateAndRemoveUntil(context, const DashboardInitScreen());
          }
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

  Future<void> logout(BuildContext context) async {
    _loader.setLoadingTo(true);
    try {
      await SecureStorageService().clearUserCredentials();
      if (context.mounted) {
        showSnackbar(context, 'Logged out successfully.');
        navigateAndRemoveUntil(context, const LoginScreen());
      }
    } catch (error) {
      if (context.mounted) {
        showSnackbar(context, 'An unexpected error occurred: $error');
      }
    } finally {
      _loader.setLoadingTo(false);
    }
  }

  Future<void> autoLogin(BuildContext context) async {
    _loader.setLoadingTo(true);

    try {
      // Load credentials from secure storage
      final credentials = await SecureStorageService().loadUserCredentials();
      final email = credentials['email'];
      final password = credentials['password'];

      if (email != null && password != null) {
        if (context.mounted) {
          await login(context: context, email: email, password: password);
        }
      } else {
        if (context.mounted) {
          navigateAndRemoveUntil(context, const AuthScreen());
        }
      }
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
final authProvider = StateNotifierProvider<AuthNotifier, Auth?>((ref) {
  final loader = ref.read(loaderProvider.notifier);
  final authApi = ref.read(authApiProvider);
  return AuthNotifier(
    loader: loader,
    authApi: authApi,
  );
});
