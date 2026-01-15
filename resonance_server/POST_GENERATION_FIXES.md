# Post-Generation Fixes

After running `serverpod generate`, you'll need to make these fixes:

## 1. Fix Transcript Segments in Ingestion Pipeline

In `lib/src/services/ingestion_pipeline.dart`, replace the placeholder transcript segment creation:

**Find:**
```dart
segments: transcriptSegments.map((s) {
  // This will be replaced with actual TranscriptSegment after generation
  return {}; // Placeholder - will be fixed after model generation
}).toList(),
```

**Replace with:**
```dart
segments: transcriptSegments.map((s) => TranscriptSegment(
  startTime: s.startTime,
  endTime: s.endTime,
  text: s.text,
  speaker: s.speaker,
)).toList(),
```

## 2. Fix Semantic Chunk Storage

In `lib/src/services/ingestion_pipeline.dart`, uncomment and fix the chunk storage:

**Find:**
```dart
// Store semantic chunks
// Note: After models are generated, this will use the actual SemanticChunk model
final storedChunks = <dynamic>[]; // Will be SemanticChunk after generation
for (final chunk in semanticChunks) {
  // This will be uncommented after model generation
  /*
  final stored = await SemanticChunk.insert(
    session,
    SemanticChunk(
      transcript: transcript,
      podcast: podcast,
      startTime: chunk.startTime,
      endTime: chunk.endTime,
      text: chunk.text,
      embedding: chunk.embedding,
    ),
  );
  storedChunks.add(stored);
  */
  // Temporary placeholder
  storedChunks.add(chunk);
}
```

**Replace with:**
```dart
// Store semantic chunks
final storedChunks = <SemanticChunk>[];
for (final chunk in semanticChunks) {
  final stored = await SemanticChunk.insert(
    session,
    SemanticChunk(
      transcript: transcript,
      podcast: podcast,
      startTime: chunk.startTime,
      endTime: chunk.endTime,
      text: chunk.text,
      embedding: chunk.embedding,
    ),
  );
  storedChunks.add(stored);
}
```

## 3. Fix Chunk Processing Loop

In `lib/src/services/ingestion_pipeline.dart`, fix the chunk processing:

**Find:**
```dart
for (final chunk in storedChunks) {
  // Extract text and timestamps from chunk
  // After model generation, this will use the actual SemanticChunk model
  final chunkText = chunk is _SemanticChunk ? chunk.text : '';
  final chunkStartTime = chunk is _SemanticChunk ? chunk.startTime : 0.0;
  final chunkEndTime = chunk is _SemanticChunk ? chunk.endTime : 0.0;
  
  if (chunkText.isEmpty) continue; // Skip if we can't extract text
```

**Replace with:**
```dart
for (final chunk in storedChunks) {
  final chunkText = chunk.text;
  final chunkStartTime = chunk.startTime;
  final chunkEndTime = chunk.endTime;
```

## 4. Fix Chunk-Subtopic Mapping

In `lib/src/services/ingestion_pipeline.dart`, uncomment the mapping storage:

**Find:**
```dart
// Store chunk-to-subtopic mapping
// Note: After model generation, uncomment this:
/*
await ChunkSubtopicMapping.insert(
  session,
  ChunkSubtopicMapping(
    chunk: chunk, // Will be the actual SemanticChunk
    subtopic: savedSubtopic,
    confidence: 0.8,
  ),
);
*/
```

**Replace with:**
```dart
// Store chunk-to-subtopic mapping
await ChunkSubtopicMapping.insert(
  session,
  ChunkSubtopicMapping(
    chunk: chunk,
    subtopic: savedSubtopic,
    confidence: 0.8,
  ),
);
```

## 5. Fix Subtopic Map Tracking

In `lib/src/services/ingestion_pipeline.dart`, fix the subtopic map:

**Find:**
```dart
// Track subtopic for relationship creation
if (!subtopicMap.containsKey(savedSubtopic.name)) {
  subtopicMap[savedSubtopic.name] = [];
}
// After model generation, add the actual chunk
// subtopicMap[savedSubtopic.name]!.add(chunk);
```

**Replace with:**
```dart
// Track subtopic for relationship creation
if (!subtopicMap.containsKey(savedSubtopic.name)) {
  subtopicMap[savedSubtopic.name] = [];
}
subtopicMap[savedSubtopic.name]!.add(chunk);
```

## 6. Update Type Declarations

In `lib/src/services/ingestion_pipeline.dart`, change:

**Find:**
```dart
final subtopicMap = <String, List<dynamic>>{}; // Will be List<SemanticChunk> after generation
```

**Replace with:**
```dart
final subtopicMap = <String, List<SemanticChunk>>{};
```

## 7. Remove Temporary Imports

After fixing the above, you can remove the temporary `_SemanticChunk` import from `ingestion_pipeline.dart`:

**Find:**
```dart
import 'chunking_service.dart' show ChunkingService, _SemanticChunk;
```

**Replace with:**
```dart
import 'chunking_service.dart';
```

And update the chunking service to return the actual `SemanticChunk` type after models are generated.

## Summary

The main changes are:
1. Use actual `TranscriptSegment` model instead of placeholder
2. Use actual `SemanticChunk` model instead of temporary `_SemanticChunk`
3. Uncomment all the database insert operations
4. Remove type workarounds and use proper generated types

After these fixes, the system should be fully functional!
