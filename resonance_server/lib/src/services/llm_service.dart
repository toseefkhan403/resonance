import 'package:serverpod/serverpod.dart';
import 'package:dartantic_ai/dartantic_ai.dart';
import 'dart:convert';

/// Service for LLM-based topic extraction and summarization using Gemini
class LLMService {
  /// Extracts topics from a semantic chunk
  /// Returns a structured response with primary subtopic, secondary concepts, and summary
  static Future<TopicExtractionResult> extractTopics(
    Session session,
    String chunkText,
  ) async {
    try {
      final apiKey = session.serverpod.getPassword('gemini_api_key');
      if (apiKey == null || apiKey.isEmpty) {
        throw Exception('Gemini API key not configured');
      }

      final agent = Agent('google:gemini-1.5-flash', apiKey: apiKey);
      
      final prompt = '''
Analyze the following text segment from a podcast and extract:
1. A primary subtopic as a short noun phrase (2-5 words)
2. Secondary concepts as a comma-separated list of short phrases
3. A concise, human-readable summary (2-3 sentences)

Text: "$chunkText"

Respond in JSON format:
{
  "primarySubtopic": "short noun phrase",
  "secondaryConcepts": ["concept1", "concept2", ...],
  "summary": "concise summary text"
}
''';

      final history = [
        const ChatMessage.system(
          'You are a knowledge extraction system. Always respond with valid JSON only, no additional text.',
        ),
      ];

      final result = await agent.send(
        prompt,
        history: history,
      );

      if (result.output != null && result.output!.isNotEmpty) {
        final jsonData = json.decode(result.output!) as Map<String, dynamic>;
        
        return TopicExtractionResult(
          primarySubtopic: jsonData['primarySubtopic'] as String,
          secondaryConcepts: (jsonData['secondaryConcepts'] as List)
              .map((e) => e.toString())
              .toList(),
          summary: jsonData['summary'] as String,
        );
      } else {
        throw Exception('Failed to extract topics: empty response');
      }
    } catch (e) {
      session.log('Error extracting topics: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Categorizes a subtopic into a higher-level category
  static Future<String> categorizeSubtopic(
    Session session,
    String subtopicName,
    List<String> existingCategories,
  ) async {
    try {
      final apiKey = session.serverpod.getPassword('gemini_api_key');
      if (apiKey == null || apiKey.isEmpty) {
        throw Exception('Gemini API key not configured');
      }

      final agent = Agent('google:gemini-1.5-flash', apiKey: apiKey);
      
      final categoriesList = existingCategories.isEmpty
          ? 'No existing categories'
          : existingCategories.join(', ');
      
      final prompt = '''
Given the subtopic "$subtopicName" and existing categories: $categoriesList

Determine the most appropriate category for this subtopic. If an existing category fits well, use it. Otherwise, suggest a new broad domain category name (1-2 words).

Respond with ONLY the category name, nothing else.
''';

      final history = [
        const ChatMessage.system(
          'You are a categorization system. Respond with only the category name.',
        ),
      ];

      final result = await agent.send(
        prompt,
        history: history,
      );

      if (result.output != null && result.output!.isNotEmpty) {
        final category = result.output!.trim();
        return category.isNotEmpty ? category : 'General';
      } else {
        return 'General';
      }
    } catch (e) {
      session.log('Error categorizing subtopic: $e', level: LogLevel.error);
      return 'General';
    }
  }

  /// Generates a conversational answer with speaker perspective
  static Future<String> generateConversationalAnswer(
    Session session,
    String question,
    List<ContextChunk> contextChunks,
    List<String> speakers,
  ) async {
    try {
      final apiKey = session.serverpod.getPassword('gemini_api_key');
      if (apiKey == null || apiKey.isEmpty) {
        throw Exception('Gemini API key not configured');
      }

      final agent = Agent('google:gemini-1.5-flash', apiKey: apiKey);
      
      final contextText = contextChunks
          .map((chunk) => '[${chunk.startTime}s-${chunk.endTime}s] ${chunk.text}')
          .join('\n\n');
      
      final speakersList = speakers.isEmpty ? 'the speakers' : speakers.join(' and ');
      
      final prompt = '''
You are answering a question as if you were $speakersList from a podcast.

Question: "$question"

Context from the podcast:
$contextText

Answer the question using ONLY the information provided in the context. 
Maintain the tone and perspective of $speakersList.
Do not make up information not present in the context.
If the context doesn't contain enough information, say so clearly.

Answer:
''';

      final history = [
        const ChatMessage.system(
          'You are a podcast speaker answering questions based on the provided context.',
        ),
      ];

      final result = await agent.send(
        prompt,
        history: history,
      );

      if (result.output != null && result.output!.isNotEmpty) {
        return result.output!;
      } else {
        throw Exception('Failed to generate answer: empty response');
      }
    } catch (e) {
      session.log('Error generating answer: $e', level: LogLevel.error);
      rethrow;
    }
  }
}

/// Result of topic extraction
class TopicExtractionResult {
  final String primarySubtopic;
  final List<String> secondaryConcepts;
  final String summary;

  TopicExtractionResult({
    required this.primarySubtopic,
    required this.secondaryConcepts,
    required this.summary,
  });
}

/// Context chunk for RAG
class ContextChunk {
  final String text;
  final double startTime;
  final double endTime;
  final String? speaker;

  ContextChunk({
    required this.text,
    required this.startTime,
    required this.endTime,
    this.speaker,
  });
}
