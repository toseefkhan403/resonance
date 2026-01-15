import 'package:serverpod/serverpod.dart';
import 'package:dartantic_ai/dartantic_ai.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math' as math;

/// Service for generating embeddings using Gemini API
class EmbeddingService {
  /// Generates an embedding vector for the given text
  /// Returns a Vector(768) representing the embedding
  static Future<Vector> generateEmbedding(
    Session session,
    String text,
  ) async {
    try {
      final apiKey = session.serverpod.getPassword('gemini_api_key');
      if (apiKey == null || apiKey.isEmpty) {
        throw Exception('Gemini API key not configured');
      }

      // Use Gemini's embedding API directly
      final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/text-embedding-004:embedContent?key=$apiKey',
      );
      
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'model': 'models/text-embedding-004',
          'content': {
            'parts': [
              {'text': text}
            ]
          }
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final embedding = data['embedding']?['values'] as List<dynamic>?;
        
        if (embedding != null && embedding.isNotEmpty) {
          // Convert to Vector(768) - ensure exactly 768 dimensions
          final embeddingList = List<double>.generate(
            768,
            (i) => i < embedding.length ? (embedding[i] as num).toDouble() : 0.0,
          );
          return Vector(embeddingList);
        } else {
          throw Exception('Failed to generate embedding: empty response');
        }
      } else {
        session.log(
          'Embedding API error: ${response.statusCode} - ${response.body}',
          level: LogLevel.error,
        );
        throw Exception('Failed to generate embedding');
      }
    } catch (e) {
      session.log('Error generating embedding: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Calculates cosine similarity between two embeddings
  static double cosineSimilarity(Vector a, Vector b) {
    if (a.length != b.length) {
      throw Exception('Embeddings must have the same dimension');
    }

    double dotProduct = 0.0;
    double normA = 0.0;
    double normB = 0.0;

    for (int i = 0; i < a.length; i++) {
      dotProduct += a[i] * b[i];
      normA += a[i] * a[i];
      normB += b[i] * b[i];
    }

    if (normA == 0.0 || normB == 0.0) {
      return 0.0;
    }

    return dotProduct / (math.sqrt(normA) * math.sqrt(normB));
  }

  /// Batch generates embeddings for multiple texts
  static Future<List<Vector>> generateEmbeddingsBatch(
    Session session,
    List<String> texts,
  ) async {
    final embeddings = <Vector>[];
    
    // Process in batches to avoid rate limits
    const batchSize = 10;
    for (int i = 0; i < texts.length; i += batchSize) {
      final batch = texts.sublist(
        i,
        i + batchSize > texts.length ? texts.length : i + batchSize,
      );
      
      final batchEmbeddings = await Future.wait(
        batch.map((text) => generateEmbedding(session, text)),
      );
      
      embeddings.addAll(batchEmbeddings);
    }
    
    return embeddings;
  }
}
