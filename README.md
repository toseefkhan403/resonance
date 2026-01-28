# Resonance

**Transform Youtube podcasts into explorable knowledge graphs.**

Resonance is live at: [https://resonance.serverpod.space/app/](https://resonance.serverpod.space/app/)

Resonance reimagines how we consume long-form content. Instead of scrubbing through hours of linear content, Resonance transforms podcasts into interactive, navigable knowledge graphs, allowing you to explore and save ideas, connections, and insights.

## 🌟 Key Features

### 🕸️ Interactive Knowledge Graphs
Visualize entire conversations at a glance. Concepts are represented as nodes in a physics-based graph, clustering related ideas together and revealing the hidden structure of the conversation.

### 🎯 Instant Contextual Playback
Stop searching for timestamps. Tap any node in the graph to instantly view the concept and jump to the exact moment it was said.

###  Chat with the Speakers
Have a question about what was said? Ask it. Resonance uses advanced RAG (Retrieval Augmented Generation) to let you chat with the speakers. You can direct questions to specific speakers (e.g., "What did Mark say about AGI?").

### 🔗 Discover Hidden Connections
Resonance understands meaning, not just keywords. It automatically links semantically related ideas—even if they occur hours apart—helping you trace themes and arguments throughout the entire episode.

### 🔍 Filter by Speaker or Category
Too many nodes? Filter by speaker or category to focus on what matters to you.

### 💾 Save Nodes
Save your favorite topics to your personal knowledge base.

## 📂 Project Structure

This monorepo is divided into two main parts:

*   [**Resonance Server**](./resonance_server) (`/resonance_server`)
    *   The backend built with [Serverpod](https://serverpod.dev/). Handles ingestion, AI processing, database management, and API serving.
    *   [View Server README](./resonance_server/README.md) for setup and architecture details.

*   [**Resonance Flutter**](./resonance_flutter) (`/resonance_flutter`)
    *   The frontend application built with **Flutter**. Provides the visual interface for exploring graphs and interacting with content.
    *   [View Client README](./resonance_flutter/README.md) for build instructions and feature details.
