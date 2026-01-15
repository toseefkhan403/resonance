import 'package:resonance_server/src/generated/protocol.dart';
import 'package:resonance_server/src/services/segmentation_service.dart';
import 'package:serverpod/serverpod.dart';
import 'embedding_service.dart';

/// Service for semantic chunking based on embedding similarity
class ChunkingService {
  /// Similarity threshold below which segments should not be merged
  static const double similarityThreshold = 0.75;

  /// Merges adjacent segments until semantic similarity drops below threshold
  /// Each resulting chunk represents a single coherent idea
  static Future<List<SemanticChunk>> createSemanticChunks(
    Session session,
    List<TranscriptSegment> segments,
  ) async {
    if (segments.isEmpty) return [];

    final chunks = <SemanticChunk>[];
    var currentChunkSegments = <TranscriptSegment>[];
    Vector? currentChunkEmbedding;

    for (int i = 0; i < segments.length; i++) {
      final segment = segments[i];
      final segmentEmbedding = await EmbeddingService.generateEmbedding(
        session,
        segment.text,
      );

      if (currentChunkSegments.isEmpty) {
        // Start first chunk
        currentChunkSegments = [segment];
        currentChunkEmbedding = segmentEmbedding;
      } else {
        // Calculate similarity with current chunk
        final similarity = EmbeddingService.cosineSimilarity(
          currentChunkEmbedding!,
          segmentEmbedding,
        );

        if (similarity >= similarityThreshold) {
          // Merge into current chunk
          currentChunkSegments.add(segment);
          // Update chunk embedding (average of all segment embeddings)
          currentChunkEmbedding = _averageEmbeddings([
            currentChunkEmbedding,
            segmentEmbedding,
          ]);
        } else {
          // Create new chunk from accumulated segments
          final chunk = _createChunkFromSegments(currentChunkSegments, currentChunkEmbedding);
          chunks.add(chunk);

          // Start new chunk
          currentChunkSegments = [segment];
          currentChunkEmbedding = segmentEmbedding;
        }
      }
    }

    // Add final chunk
    if (currentChunkSegments.isNotEmpty) {
      final chunk = _createChunkFromSegments(
        currentChunkSegments,
        currentChunkEmbedding!,
      );
      chunks.add(chunk);
    }

    return chunks;
  }

  /// Creates a semantic chunk from multiple segments
  static SemanticChunk _createChunkFromSegments(
    List<TranscriptSegment> segments,
    Vector embedding,
  ) {
    final startTime = segments.first.startTime;
    final endTime = segments.last.endTime;
    final text = segments.map((s) => s.text).join(' ');

    return SemanticChunk(
      startTime: startTime,
      endTime: endTime,
      text: text,
      embedding: embedding,
    );
  }

  /// Averages multiple embeddings
  static Vector _averageEmbeddings(List<Vector> embeddings) {
    if (embeddings.isEmpty) {
      throw Exception('Cannot average empty embeddings list');
    }
    if (embeddings.length == 1) return embeddings.first;

    final dimension = embeddings.first.length;
    final averaged = List<double>.filled(dimension, 0.0);

    for (final embedding in embeddings) {
      for (int i = 0; i < dimension; i++) {
        averaged[i] += embedding[i];
      }
    }

    final count = embeddings.length.toDouble();
    for (int i = 0; i < dimension; i++) {
      averaged[i] /= count;
    }

    return Vector(averaged);
  }
}

/// Temporary model for semantic chunks (will be replaced by generated model)
class SemanticChunk {
  final double startTime;
  final double endTime;
  final String text;
  final Vector embedding;

  SemanticChunk({
    required this.startTime,
    required this.endTime,
    required this.text,
    required this.embedding,
  });
}
