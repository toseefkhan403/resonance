# Knowledge Graph System Setup Guide

This document describes the knowledge graph system for YouTube podcasts and how to set it up.

## Overview

The system implements a complete pipeline for ingesting YouTube podcasts and building a personal knowledge graph:

1. **Ingestion**: Accept YouTube URLs and create background processing jobs
2. **Transcript Acquisition**: Retrieve transcripts from YouTube captions or fallback to STT
3. **Structural Segmentation**: Split transcripts by speaker changes, pauses, and time windows
4. **Semantic Chunking**: Merge segments by semantic similarity using embeddings
5. **Topic Extraction**: Extract subtopics, concepts, and summaries using LLM
6. **Topic Normalization**: Deduplicate and canonicalize subtopics
7. **Graph Merge**: Merge new subtopics with existing graph using similarity
8. **Relationship Construction**: Create category→subtopic, subtopic→subtopic, and subtopic→podcast links
9. **Vector Storage**: Maintain separate vectors for chunks, subtopics, and summaries
10. **Graph Materialization**: Expose API for force-directed graph visualization
11. **Node Interaction**: Return detailed information when nodes are clicked
12. **Conversational AI**: RAG system for asking questions with speaker perspective

## Prerequisites

1. **Serverpod**: Ensure Serverpod is properly installed
2. **PostgreSQL**: Database must be running and configured
3. **Gemini API Key**: Required for embeddings and LLM operations
4. **Dependencies**: Run `dart pub get` to install required packages

## Setup Steps

### 1. Install Dependencies

```bash
cd resonance_server
dart pub get
```

### 2. Configure API Keys

Add your Gemini API key to `config/passwords.yaml`:

```yaml
gemini_api_key: your-api-key-here
```

### 3. Generate Models and Endpoints

After creating the model definitions, run:

```bash
serverpod generate
```

This will:

- Generate Dart classes from the `.spy.yaml` model files
- Create database migrations
- Generate endpoint code
- Update the protocol

### 4. Apply Database Migrations

```bash
dart bin/main.dart --apply-migrations
```

Or when starting the server:

```bash
serverpod start
```

### 5. Start the Server

```bash
dart bin/main.dart
```

Or use the Serverpod script:

```bash
serverpod start
```

## Model Definitions

All models are defined in `lib/src/models/*.spy.yaml`:

- **Podcast**: YouTube podcast metadata
- **IngestionJob**: Background job tracking
- **Transcript**: Raw transcript with segments
- **SemanticChunk**: Coherent ideas with embeddings
- **Category**: High-level topic domains
- **Subtopic**: Specific ideas/concepts
- **ChunkSubtopicMapping**: Links chunks to subtopics
- **GraphRelationship**: Edges in the knowledge graph
- **PodcastSubtopicEvidence**: Provenance links

## API Endpoints

### Podcast Endpoint (`/podcast`)

- `ingestPodcast(String youtubeUrl)`: Start ingestion process
- `getJobStatus(int jobId)`: Check job status
- `listPodcasts()`: List all user's podcasts

### Graph Endpoint (`/graph`)

- `getGraphData()`: Get complete graph for visualization
- `getSubtopicDetail(int subtopicId)`: Get detailed info for a subtopic

### Conversation Endpoint (`/conversation`)

- `askQuestion(String question)`: Ask a question using RAG

## Background Processing

The system uses Serverpod's `FutureCall` mechanism for background processing:

1. User submits YouTube URL via `ingestPodcast`
2. Job is created and immediately returned
3. `ProcessPodcastCall` is scheduled to run in background
4. Pipeline processes through all 12 steps
5. Job status is updated throughout processing

## Vector Storage Strategy

The system maintains separate vector representations:

1. **Semantic Chunks**: Stored in `SemanticChunk.embedding` for timestamp retrieval
2. **Subtopics**: Stored in `Subtopic.embedding` for graph layout and clustering
3. **Summaries**: Can be embedded on-demand for conversational retrieval

## Configuration

### Embedding Model

Default: `text-embedding-004` (Gemini) - produces 768-dimensional vectors

To change, modify `EmbeddingService.generateEmbedding()`.

### LLM Model

Default: `gemini-1.5-flash` (Gemini)

To change, modify `LLMService.extractTopics()` and `LLMService.generateConversationalAnswer()`.

### Similarity Thresholds

- Semantic chunking: 0.75 (in `ChunkingService`)
- Subtopic merging: 0.85 (in `GraphService`)
- Relationship creation: 0.7 (in `GraphService`)
- RAG retrieval: 0.6 (in `ConversationEndpoint`)

## Notes

- All data is scoped per user (via `userId`)
- Background processing is mandatory (no synchronous execution)
- Every relationship is explainable in plain language
- Raw transcripts are preserved permanently for reprocessing
- The system is designed to be deterministic in output shape

## Troubleshooting

### Models Not Generated

Run `serverpod generate` after creating or modifying `.spy.yaml` files.

### Database Errors

Ensure migrations are applied: `dart bin/main.dart --apply-migrations`

### API Key Errors

Check that `gemini_api_key` is set in `config/passwords.yaml`

### Future Call Not Executing

Verify that `ProcessPodcastCall` is registered in `server.dart`:

```dart
pod.registerFutureCall(ProcessPodcastCall(), 'processPodcast');
```

## Next Steps

After setup:

1. Generate models: `serverpod generate`
2. Apply migrations: `dart bin/main.dart --apply-migrations`
3. Start server: `dart bin/main.dart`
4. Test ingestion: Call `client.podcast.ingestPodcast(youtubeUrl)`
