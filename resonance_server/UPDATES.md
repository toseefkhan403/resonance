# Updates Summary

## Changes Made

### 1. Dependencies Updated
- **Removed**: `yt_transcript`, `youtube_explode_dart`
- **Added**: `youtube_transcript_api: ^1.0.0`, `dartantic_ai: ^1.0.0`

### 2. Embedding Storage
- **Changed from**: `List<double>` (JSON array)
- **Changed to**: `Vector(768)` (native Serverpod Vector type)
- **Models updated**:
  - `semantic_chunk.spy.yaml`: `embedding: Vector(768)`
  - `subtopic.spy.yaml`: `embedding: Vector(768)`

### 3. YouTube Transcript Service
- **Updated**: `YouTubeService` now uses `youtube_transcript_api` package
- **Method**: `YoutubeTranscriptApi.getTranscript(videoId)`
- **Handles**: Both Map and TranscriptItem return types

### 4. Embedding Service
- **Changed from**: OpenAI API (`text-embedding-3-small`)
- **Changed to**: Gemini API (`text-embedding-004`)
- **Returns**: `Vector(768)` instead of `List<double>`
- **API Key**: Changed from `openai_api_key` to `gemini_api_key`
- **Direct API call**: Uses HTTP to call Gemini embedding endpoint

### 5. LLM Service
- **Changed from**: OpenAI API (`gpt-4o-mini`)
- **Changed to**: Gemini API via `dartantic_ai` (`gemini-1.5-flash`)
- **Package**: Uses `dartantic_ai` Agent API
- **Methods updated**:
  - `extractTopics()`: Uses `Agent('google:gemini-1.5-flash')`
  - `categorizeSubtopic()`: Uses `Agent('google:gemini-1.5-flash')`
  - `generateConversationalAnswer()`: Uses `Agent('google:gemini-1.5-flash')`

### 6. Service Updates
- **ChunkingService**: Updated to use `Vector` instead of `List<double>`
- **GraphService**: Updated to use `Vector` instead of `List<double>`
- **EmbeddingService**: Updated cosine similarity to work with `Vector` type

## Configuration Changes

### API Key
Update `config/passwords.yaml`:
```yaml
# Old
openai_api_key: your-key-here

# New
gemini_api_key: your-key-here
```

## Benefits

1. **Native Vector Support**: Serverpod's Vector type provides better database integration and performance
2. **Fixed Dimensions**: 768-dimensional vectors ensure consistency
3. **Gemini Integration**: Using Google's Gemini API via dartantic_ai
4. **Better Package**: youtube_transcript_api is more reliable than previous packages

## Next Steps

1. Run `dart pub get` to install new dependencies
2. Update `config/passwords.yaml` with Gemini API key
3. Run `serverpod generate` to regenerate models with Vector types
4. Apply migrations: `dart bin/main.dart --apply-migrations`
5. Test the system with a YouTube URL

## Notes

- Vector(768) is a Serverpod native type that stores embeddings efficiently
- Gemini's text-embedding-004 model produces 768-dimensional vectors
- dartantic_ai provides a clean API for Gemini chat completions
- youtube_transcript_api handles YouTube transcript retrieval reliably
