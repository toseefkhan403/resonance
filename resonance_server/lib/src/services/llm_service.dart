import 'package:resonance_server/src/generated/protocol.dart';
import 'package:resonance_server/src/services/youtube_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:dartantic_ai/dartantic_ai.dart';

import 'package:dartantic_interface/dartantic_interface.dart';
import 'package:resonance_server/src/services/llm_prompts.dart';

/// Service for LLM-based topic extraction and summarization using Gemini
class LLMService {
  final String _geminiAPIKey;

  LLMService()
    : _geminiAPIKey = Serverpod.instance.getPassword('geminiAPIKey')!;

  LLMService.withAPIKey(String geminiAPIKey) : _geminiAPIKey = geminiAPIKey;

  /// Returns Agentic segmented transcript with speaker info and timestamps
  Future<SegmentedTranscript> getSegmentedTranscript(
    Session session,
    Podcast podcast,
  ) async {
    try {
      final ytService = YouTubeService();

      final audioFile = await ytService.downloadYouTubeAudio(
        podcast.youtubeUrl,
      );
      final audioBytes = await audioFile.readAsBytes();
      final agent = _createAgent();

      final result = await agent.sendFor<SegmentedTranscript>(
        LLMPrompts.segmentedTranscriptPrompt(
          podcast.title,
          podcast.channelName,
        ),
        attachments: [
          DataPart(audioBytes, mimeType: 'audio/mp3'),
        ],
        outputSchema: LLMPrompts.segmentedTranscriptSchema,
        outputFromJson: SegmentedTranscript.fromJson,
      );

      return result.output;
    } catch (e) {
      session.log(
        'Error fetching segmented transcript: $e',
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
      'google?chat=gemini-2.5-flash&embeddings=text-embedding-004',
      embeddingsModelOptions: const GoogleEmbeddingsModelOptions(
        dimensions: 768,
      ),
    );
  }
}
