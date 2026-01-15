// import 'package:resonance_server/src/generated/protocol.dart';
// import 'package:serverpod/serverpod.dart';

// /// Service for structural segmentation of transcripts
// class SegmentationService {
//   /// Maximum segment duration in seconds
//   static const double maxSegmentDuration = 300.0; // 5 minutes
  
//   /// Minimum pause duration to split on (seconds)
//   static const double minPauseDuration = 2.0;
  
//   /// Maximum time window for a segment (seconds)
//   static const double maxTimeWindow = 600.0; // 10 minutes

//   /// Splits transcript into structural segments based on:
//   /// - Speaker changes
//   /// - Long pauses
//   /// - Maximum time window constraints
//   static List<TranscriptSegment> segmentTranscript(
//     Session session,
//     List<TranscriptSegment> segments,
//   ) {
//     if (segments.isEmpty) return [];

//     final structuralSegments = <TranscriptSegment>[];
//     var currentSegmentStart = segments.first.startTime;
//     var currentSegmentText = <String>[];
//     String? currentSpeaker = segments.first.speaker;
//     var lastEndTime = segments.first.startTime;

//     for (final segment in segments) {
//       // Check for speaker change
//       final speakerChanged = currentSpeaker != null &&
//           segment.speaker != null &&
//           currentSpeaker != segment.speaker;

//       // Check for long pause
//       final pauseDuration = segment.startTime - lastEndTime;
//       final hasLongPause = pauseDuration >= minPauseDuration;

//       // Check if we've exceeded max time window
//       final exceedsTimeWindow = 
//           (segment.endTime - currentSegmentStart) >= maxTimeWindow;

//       // Check if we've exceeded max segment duration
//       final exceedsMaxDuration = 
//           (segment.endTime - currentSegmentStart) >= maxSegmentDuration;

//       // Create new segment if any condition is met
//       if (speakerChanged || hasLongPause || exceedsTimeWindow || exceedsMaxDuration) {
//         if (currentSegmentText.isNotEmpty) {
//           structuralSegments.add(TranscriptSegment(
//             startTime: currentSegmentStart,
//             endTime: lastEndTime,
//             text: currentSegmentText.join(' '),
//             speaker: currentSpeaker,
//           ));
//         }

//         // Start new segment
//         currentSegmentStart = segment.startTime;
//         currentSegmentText = [segment.text];
//         currentSpeaker = segment.speaker;
//       } else {
//         // Continue current segment
//         currentSegmentText.add(segment.text);
//       }

//       lastEndTime = segment.endTime;
//     }

//     // Add final segment
//     if (currentSegmentText.isNotEmpty) {
//       structuralSegments.add(TranscriptSegment(
//         startTime: currentSegmentStart,
//         endTime: lastEndTime,
//         text: currentSegmentText.join(' '),
//         speaker: currentSpeaker,
//       ));
//     }

//     return structuralSegments;
//   }
// }
