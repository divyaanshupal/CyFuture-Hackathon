import 'package:cyfuture_app/features/home/services/apiService.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Providers
final caseProvider = StateNotifierProvider<CaseNotifier, String>(
  (ref) => CaseNotifier(ref),
);

final predictionProvider = StateProvider<String>((ref) => '');

class CaseNotifier extends StateNotifier<String> {
  final Ref ref;  // Keep a reference to ref

  CaseNotifier(this.ref) : super('');

  void update(String newText) {
    state = newText;
  }

  Future<void> predict() async {
    final prediction = await ApiService.predictCase(state);

    // Update the predictionProvider using ref
    ref.read(predictionProvider.notifier).state = prediction;
  }
}
