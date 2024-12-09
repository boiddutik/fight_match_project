import 'package:fight_match_app/core/utils/navigators.dart';
import 'package:fight_match_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/skeletonized_waiting_widget.dart';

class DashboardInitScreen extends ConsumerWidget {
  const DashboardInitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.read(dashboardInitProvider.notifier).initialize(context);
      // ignore: prefer_const_constructors
      Future.delayed(Duration(seconds: 2), () {
        if (context.mounted) {
          navigateAndRemoveUntil(context, const DashboardScreen());
        }
      });
    });

    return const SkeletonizedWaitingWIdget();
  }
}
