class ApiService {
  static Future<String> predictCase(String details) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    // This is a mock response - replace with real API call
    return 'Based on the input, the likely outcome is: Settlement in favor of the defendant.';
  }
}
