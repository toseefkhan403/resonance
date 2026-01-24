import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resonance_flutter/presentation/controllers/home_controller.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController _urlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _handleGenerate() async {
    final url = _urlController.text.trim();
    await ref.read(homeControllerProvider.notifier).generate(url);
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeControllerProvider);
    final ingestionJob = homeState.ingestionJob;
    final isSubmitting = homeState.isSubmitting;

    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(24),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: ingestionJob == null && !isSubmitting
                ? _buildInputForm(homeState.errorMessage)
                : _buildProgressView(homeState),
          ),
        ),
      ),
    );
  }

  Widget _buildInputForm(String? errorMessage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      key: const ValueKey('input_form'),
      children: [
        Text(
          'Resonance',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        TextField(
          controller: _urlController,
          decoration: InputDecoration(
            labelText: 'YouTube URL',
            hintText: 'https://youtube.com/watch?v=...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.link),
            errorText: errorMessage,
          ),
          onSubmitted: (_) => _handleGenerate(),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _handleGenerate,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Generate',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressView(HomeState homeState) {
    final ingestionJob = homeState.ingestionJob;
    final progress = ingestionJob?.progress ?? 0;
    final status = ingestionJob?.status ?? 'Pending';
    final stage = ingestionJob?.stage ?? 'Initializing';
    final isError = status == 'failed';
    final isCompleted = status == 'completed';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      key: const ValueKey('progress_view'),
      children: [
        if (isError)
          const Icon(Icons.error_outline, size: 64, color: Colors.red)
        else if (isCompleted)
          const Icon(Icons.check_circle_outline, size: 64, color: Colors.green)
        else
          SizedBox(
            height: 64,
            width: 64,
            child: CircularProgressIndicator(
              value: progress / 100,
              strokeWidth: 6,
              backgroundColor: Colors.grey.withValues(alpha: 0.2),
            ),
          ),
        const SizedBox(height: 32),
        Text(
          isError
              ? 'Ingestion Failed'
              : isCompleted
              ? 'Ingestion Complete'
              : '$progress%',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isError
              ? (homeState.errorMessage ?? 'Unknown error')
              : '$status - $stage',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        if (isError || isCompleted) ...[
          const SizedBox(height: 32),
          OutlinedButton(
            onPressed: () {
              ref.read(homeControllerProvider.notifier).reset();
              _urlController.clear();
            },
            child: const Text('Start Over'),
          ),
        ],
      ],
    );
  }
}
