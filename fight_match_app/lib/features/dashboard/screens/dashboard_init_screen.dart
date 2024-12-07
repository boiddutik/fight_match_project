import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/skeletonized_waiting_widget.dart';
import '../notifiers/dashboard_init_notifier.dart';

class DashboardInitScreen extends ConsumerWidget {
  const DashboardInitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dashboardInitProvider.notifier).initialize(context);
    });

    return const SkeletonizedWaitingWIdget();
  }
}
