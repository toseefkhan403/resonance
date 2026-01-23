import 'package:resonance_server/src/generated/protocol.dart';
import 'package:resonance_server/src/services/ingestion_pipeline.dart';
import 'package:resonance_server/src/services/youtube_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:dartantic_ai/dartantic_ai.dart';

import 'package:resonance_server/src/services/llm_prompts.dart';

/// Service for LLM-based topic extraction and summarization using Gemini
class LLMService {
  late final String _geminiAPIKey;

  LLMService()
    : _geminiAPIKey = Serverpod.instance.getPassword('geminiApiKey')!;

  /// Returns Agentic segmented transcript with speaker info and timestamps
  Future<SegmentedTranscript> getSegmentedTranscript(
    Session session,
    Podcast podcast,
    int jobId,
  ) async {
    session.log(
      'LLMService: getSegmentedTranscript invoked for podcast: ${podcast.title}',
    );
    try {
      final ytService = YouTubeService();

      session.log('LLMService: Downloading audio for: ${podcast.youtubeUrl}');
      await IngestionPipeline.updateJobStatus(
        session,
        jobId,
        'processing',
        'downloading_audio',
        20,
      );
      final audioFile = await ytService.downloadYouTubeAudio(
        podcast.videoId,
        onProgress: (progress) {
          IngestionPipeline.updateJobStatus(
            session,
            jobId,
            'processing',
            'downloading_audio',
            progress,
          );
        },
      );
      session.log('LLMService: Audio downloaded: ${audioFile.path}');

      final audioBytes = await audioFile.readAsBytes();
      session.log(
        'LLMService: Audio file read, size: ${audioBytes.length} bytes',
      );
      await IngestionPipeline.updateJobStatus(
        session,
        jobId,
        'processing',
        'downloaded_audio',
        30,
      );

      final agent = _createAgent();
      await IngestionPipeline.updateJobStatus(
        session,
        jobId,
        'processing',
        'agent_created',
        35,
      );

      session.log('LLMService: Sending audio to Gemini for segmentation');
      final result = await agent.sendFor<SegmentedTranscript>(
        LLMPrompts.segmentedTranscriptPrompt(
          podcast.title,
          podcast.channelName,
        ),
        attachments: [
          DataPart(
            audioBytes,
            mimeType: 'audio/${audioFile.path.split('.').last}',
          ),
        ],
        outputSchema: LLMPrompts.segmentedTranscriptSchema,
        outputFromJson: SegmentedTranscript.fromJson,
      );
      session.log('LLMService: Received response from Gemini');
      await IngestionPipeline.updateJobStatus(
        session,
        jobId,
        'processing',
        '${result.output}',
        40,
      );

      // delete audio file
      await audioFile.delete();

      return result.output;
    } catch (e) {
      session.log(
        'LLMService: Error fetching segmented transcript: $e',
        level: LogLevel.error,
      );
      rethrow;
    }
  }

  Future<Vector> generateEmbedding(String text) async {
    final agent = _createAgent();
    try {
      final embedding = await agent.embedQuery(text);
      return Vector(embedding.embeddings);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Generates a conversational answer with speaker perspective
  Stream<String> generateConversationalAnswer(
    String question,
    String speakerName,
    List<GraphNode> nodes,
  ) async* {
    try {
      final agent = _createAgent();

      final prompt = LLMPrompts.conversationalAnswerPrompt(
        question,
        speakerName,
        nodes
            .map(
              (e) => {
                'label': e.label,
                'summary': e.summary,
                'references': e.references.map((r) => r.toString()).toList(),
                'videoId': e.videoId,
              },
            )
            .toString(),
      );

      final history = [
        ChatMessage.system(LLMPrompts.conversationalAnswerSystemMessage),
      ];

      final resultStream = agent.sendStream(
        prompt,
        history: history,
      );

      await for (final chunk in resultStream) {
        yield chunk.output;
      }
    } catch (e) {
      rethrow;
    }
  }

  Agent _createAgent() {
    Agent.environment['GEMINI_API_KEY'] = _geminiAPIKey;
    return Agent(
      'google?chat=gemini-3-flash-preview&embeddings=text-embedding-004',
      embeddingsModelOptions: const GoogleEmbeddingsModelOptions(
        dimensions: 768,
      ),
    );
  }
}
