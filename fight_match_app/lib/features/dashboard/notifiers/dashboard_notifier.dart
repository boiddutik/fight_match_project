import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardCounterNotifier extends StateNotifier<int> {
  DashboardCounterNotifier() : super(0);

  void changeDashboardCounter(int n) {
    state = n;
  }
}
// -----------------------------------------------------------------------------

final dashboardCounterProvider =
    StateNotifierProvider<DashboardCounterNotifier, int>((ref) {
  return DashboardCounterNotifier();
});
