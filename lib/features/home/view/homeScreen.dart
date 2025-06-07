import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/caseProvider.dart';
import 'package:cyfuture_app/core/theme/appTheme.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final caseDetails = ref.watch(caseProvider);
    
    if (controller.text != caseDetails) {
      controller.text = caseDetails;
    }

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.gavel_rounded,
              color: AppTheme.primaryColor.withOpacity(0.9),
              size: 28,
            ),
            const SizedBox(width: 12),
            const Text('Legal Case Predictor'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Welcome Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: AppTheme.gradientCardDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to Legal AI',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Enter your case details below for AI-powered analysis',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Case Details Card
              _buildCard(
                icon: Icons.description_outlined,
                title: 'Case Details',
                child: TextField(
                  controller: controller,
                  maxLines: 6,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: const InputDecoration(
                    hintText: 'Type your case summary here...',
                  ),
                  onChanged: (value) {
                    ref.read(caseProvider.notifier).update(value);
                  },
                ),
              ),
              const SizedBox(height: 24),
              
              // Analyze Button
              Container(
                decoration: AppTheme.buttonDecoration,
                child: ElevatedButton(
                  onPressed: () async {
                    await ref.read(caseProvider.notifier).predict();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.analytics_outlined, size: 24),
                      const SizedBox(width: 12),
                      const Text('Analyze Case'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Results Section
              Consumer(builder: (context, ref, _) {
                final result = ref.watch(predictionProvider);
                if (result.isEmpty) return const SizedBox();
                return _buildCard(
                  icon: Icons.insights_outlined,
                  title: 'Analysis Result',
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: AppTheme.resultContainerDecoration,
                    child: Text(
                      result,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            height: 1.6,
                            letterSpacing: 0.3,
                          ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppTheme.whiteCardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: AppTheme.iconContainerDecoration,
                child: Icon(
                  icon,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}