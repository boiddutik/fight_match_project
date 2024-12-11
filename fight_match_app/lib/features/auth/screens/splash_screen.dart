import 'package:fight_match_app/core/utils/navigators.dart';
import 'package:fight_match_app/features/profile/screens/create_profile_screens/create_profile_name_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/skeletonized_waiting_widget.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.read(authProvider.notifier).autoLogin(context);
      navigateAndRemoveUntil(context, const CreateProfileNameScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SkeletonizedWaitingWIdget(),
      ),
    );
  }
}
