import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoaderNotifier extends StateNotifier<bool> {
  LoaderNotifier() : super(false);

  void setLoadingTo(bool value) {
    state = value;
  }
}
// -----------------------------------------------------------------------------

final loaderProvider = StateNotifierProvider<LoaderNotifier, bool>((ref) {
  return LoaderNotifier();
});
