import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'embedding_service.dart';

/// Service for graph construction and merging
class GraphService {
  /// Similarity threshold for merging subtopics
  static const double mergeThreshold = 0.85;

  /// Merges a new subtopic with existing subtopics in the user's graph
  /// Returns the existing subtopic if merged, or creates a new one
  static Future<Subtopic> mergeOrCreateSubtopic(
    Session session,
    String userId,
    String subtopicName,
    Vector embedding,
    String categoryName,
    List<String> secondaryConcepts,
    String summary,
  ) async {
    // Get all existing subtopics for this user
    final existingSubtopics = await Subtopic.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );

    // Find the most similar existing subtopic
    double maxSimilarity = 0.0;
    Subtopic? mostSimilar;

    for (final existing in existingSubtopics) {
      final similarity = EmbeddingService.cosineSimilarity(
        embedding,
        existing.embedding,
      );

      if (similarity > maxSimilarity) {
        maxSimilarity = similarity;
        mostSimilar = existing;
      }
    }

    // Merge if similarity exceeds threshold
    if (maxSimilarity >= mergeThreshold && mostSimilar != null) {
      // Update existing subtopic with merged information
      final updatedSecondaryConcepts = [
        ...mostSimilar.secondaryConcepts,
        ...secondaryConcepts,
      ].toSet().toList(); // Remove duplicates

      final updatedSummary = _mergeSummaries(
        mostSimilar.summary,
        summary,
      );

      // Update importance score (average or weighted)
      final updatedImportance = (mostSimilar.importanceScore + 0.5) / 2.0;

      // Update the existing subtopic
      final updatedSubtopic = mostSimilar.copyWith(
        secondaryConcepts: updatedSecondaryConcepts,
        summary: updatedSummary,
        importanceScore: updatedImportance,
        updatedAt: DateTime.now(),
      );
      
      await Subtopic.db.updateRow(session, updatedSubtopic);
      
      return updatedSubtopic;
    } else {
      // Create new subtopic
      // First, get or create the category
      final category = await _getOrCreateCategory(
        session,
        userId,
        categoryName,
      );

      return Subtopic(
        userId: userId,
        name: subtopicName,
        category: category,
        secondaryConcepts: secondaryConcepts,
        summary: summary,
        embedding: embedding,
        importanceScore: 0.5,
      );
    }
  }

  /// Gets or creates a category
  static Future<Category> _getOrCreateCategory(
    Session session,
    String userId,
    String categoryName,
  ) async {
    final existing = await Category.db.findFirstRow(
      session,
      where: (c) => c.userId.equals(userId) & c.name.equals(categoryName),
    );

    if (existing != null) {
      return existing;
    }

    return await Category.db.insertRow(
      session,
      Category(
        userId: userId,
        name: categoryName,
        description: null,
      ),
    );
  }

  /// Merges two summaries intelligently
  static String _mergeSummaries(String summary1, String summary2) {
    // Simple merge: combine if different, otherwise return the longer one
    if (summary1 == summary2) {
      return summary1.length > summary2.length ? summary1 : summary2;
    }

    // Combine summaries, removing redundancy
    final combined = '$summary1 $summary2';
    // In a production system, you might use LLM to merge summaries
    return combined;
  }

  /// Creates graph relationships
  static Future<void> createRelationships(
    Session session,
    String userId,
    Subtopic subtopic,
    Podcast podcast,
    List<Subtopic> relatedSubtopics,
  ) async {
    // Category → Subtopic (membership)
    if (subtopic.category != null) {
      await _createOrUpdateRelationship(
        session,
        userId,
        subtopic.category!.id!,
        'category',
        subtopic.id!,
        'subtopic',
        'membership',
        1.0,
      );
    }

    // Subtopic → Subtopic (semantic similarity)
    for (final related in relatedSubtopics) {
      final similarity = EmbeddingService.cosineSimilarity(
        subtopic.embedding,
        related.embedding,
      );

      if (similarity >= 0.7) {
        await _createOrUpdateRelationship(
          session,
          userId,
          subtopic.id!,
          'subtopic',
          related.id!,
          'subtopic',
          'similarity',
          similarity,
        );
      }
    }

    // Subtopic → Podcast (evidence and provenance)
    await _createOrUpdateRelationship(
      session,
      userId,
      subtopic.id!,
      'subtopic',
      podcast.id!,
      'podcast',
      'provenance',
      1.0,
    );
  }

  /// Creates or updates a graph relationship
  static Future<void> _createOrUpdateRelationship(
    Session session,
    String userId,
    int sourceId,
    String sourceType,
    int targetId,
    String targetType,
    String relationType,
    double weight,
  ) async {
    final existing = await GraphRelationship.db.findFirstRow(
      session,
      where: (r) =>
          r.userId.equals(userId) &
          r.sourceId.equals(sourceId) &
          r.targetId.equals(targetId) &
          r.relationType.equals(relationType),
    );

    if (existing != null) {
      // Update weight (could be average, max, or sum depending on use case)
      await session.db.update(
        'graph_relationship',
        {
          'weight': (existing.weight + weight) / 2.0,
          'updatedAt': DateTime.now().toIso8601String(),
        },
        where: 'id = @id',
        substitutionValues: {'id': existing.id},
      );
    } else {
      // Create new relationship
      await GraphRelationship.db.insertRow(
        session,
        GraphRelationship(
          userId: userId,
          sourceId: sourceId,
          sourceType: sourceType,
          targetId: targetId,
          targetType: targetType,
          relationType: relationType,
          weight: weight,
        ),
      );
    }
  }
}
