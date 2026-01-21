import 'package:flutter/material.dart';
import 'package:resonance_client/resonance_client.dart';
import 'package:resonance_flutter/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _urlController = TextEditingController();
  IngestionJob? _ingestionJob;
  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _handleGenerate() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a YouTube URL';
      });
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      final job = await client.podcast.ingestPodcast(url);
      if (mounted) {
        setState(() {
          _ingestionJob = job;
          _isSubmitting = false;
        });
        _monitorJobStatus(job.id!);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isSubmitting = false;
        });
      }
    }
  }

  void _monitorJobStatus(int jobId) {
    client.podcast
        .getJobStatus(jobId)
        .listen(
          (job) {
            if (mounted) {
              setState(() {
                _ingestionJob = job;
              });
            }
          },
          onError: (e) {
            if (mounted) {
              setState(() {
                _errorMessage = e.toString();
              });
            }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(24),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _ingestionJob == null && !_isSubmitting
                ? _buildInputForm()
                : _buildProgressView(),
          ),
        ),
      ),
    );
  }

  Widget _buildInputForm() {
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
            errorText: _errorMessage,
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

  Widget _buildProgressView() {
    final progress = _ingestionJob?.progress ?? 0;
    final status = _ingestionJob?.status ?? 'Pending';
    final stage = _ingestionJob?.stage ?? 'Initializing';
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
              backgroundColor: Colors.grey.withOpacity(0.2),
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
          isError ? (_errorMessage ?? 'Unknown error') : '$status - $stage',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        if (isError || isCompleted) ...[
          const SizedBox(height: 32),
          OutlinedButton(
            onPressed: () {
              setState(() {
                _ingestionJob = null;
                _errorMessage = null;
                _urlController.clear();
              });
            },
            child: const Text('Start Over'),
          ),
        ],
      ],
    );
  }
}
