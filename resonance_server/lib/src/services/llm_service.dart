import 'dart:io';

import 'package:resonance_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:dartantic_ai/dartantic_ai.dart';

import 'package:resonance_server/src/services/llm_prompts.dart';

class LLMService {
  late final String _geminiAPIKey;

  late final Agent _agent = _createAgent();

  LLMService()
    : _geminiAPIKey = Serverpod.instance.getPassword('geminiApiKey')!;

  /// Returns Agentic segmented transcript with speaker info and timestamps
  Future<SegmentedTranscript> getSegmentedTranscript(
    Session session,
    Podcast podcast,
    int jobId,
    File audioFile,
  ) async {
    try {
      final audioBytes = await audioFile.readAsBytes();
      session.log(
        'LLMService: Audio file read, size: ${audioBytes.length} bytes',
      );

      final attachments = <DataPart>[
        DataPart(
          audioBytes,
          mimeType: 'audio/${audioFile.path.split('.').last}',
        ),
      ];

      final result = await _agent.sendFor<SegmentedTranscript>(
        LLMPrompts.segmentedTranscriptPrompt(
          podcast.title,
          podcast.channelName,
        ),
        attachments: attachments,
        outputSchema: LLMPrompts.segmentedTranscriptSchema,
        outputFromJson: SegmentedTranscript.fromJson,
      );
      session.log('LLMService: Received response from Gemini');

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
    try {
      final embedding = await _agent.embedQuery(text);
      return Vector(embedding.embeddings);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Vector>> generateEmbeddings(List<String> texts) async {
    try {
      final futures = texts.map((text) => _agent.embedQuery(text));
      final results = await Future.wait(futures);
      return results.map((e) => Vector(e.embeddings)).toList();
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

      final resultStream = _agent.sendStream(
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
