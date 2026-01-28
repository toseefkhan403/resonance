# Resonance Server

The backend for **Resonance**, a platform that transforms audio content (podcasts) into interactive, explorable knowledge graphs.

## 🚀 Overview

This server manages the entire ingestion pipeline, from fetching YouTube transcripts to orchestrating AI for semantic content segmentation and knowledge extraction. It exposes robust API via Serverpod for the Flutter client.

## ✨ Key Features

- **Ingestion Pipeline**: Automated system to fetch, process, and analyze YouTube podcasts.
- **Agentic AI**:
  - **Transcript Segmentation**: Uses Gemini (via `dartantic_ai`) to break down long transcripts into semantic segments.
  - **Speaker Diarization**: Identifies speakers in the transcript.
  - **Knowledge Extraction**: Identifies key concepts and relationships to build a knowledge graph.
- **Graph Construction**: Uses vector embeddings to link semantically similar ideas and construct a traversable graph structure.
- **Data Management**: Powered by PostgreSQL for efficient storage and retrieval.
- **API**: Full-featured Serverpod API handling authentication, background processing, streaming job status updates, graph data serving and RAG for speaker-based conversational AI.

## 🛠️ Tech Stack

- **Framework**: [Serverpod 3.2.1](https://serverpod.dev/)
- **Language**: Dart
- **AI Integration**: [Dartantic AI](https://pub.dev/packages/dartantic_ai) (Gemini)
- **Database**: PostgreSQL

## ⚡ Getting Started

### Prerequisites

- **Docker**: Required for running PostgreSQL and Redis.
- **Dart SDK**: Version 3.10.0 or higher.
- **API Keys**: A valid Gemini API key is required for AI features.

### Setup & Run

1.  **Start Infrastructure**:
    Use Docker Compose to spin up the database and Redis cache.
    ```bash
    docker compose up --build --detach
    ```

2.  **Configure Environment**:
    Ensure your `config/passwords.yaml` has the necessary API keys set, particularly for Gemini.

3.  **Run the Server**:
    Start the server with migration application.
    ```bash
    dart pub get
    serverpod generate
    serverpod create-migration
    dart run bin/main.dart --apply-migrations
    ```

4.  **Stopping**:
    Shut down the server with `Ctrl-C` and stop containers:
    ```bash
    docker compose down
    ```
