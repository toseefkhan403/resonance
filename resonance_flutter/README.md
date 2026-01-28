# Resonance Client

The Flutter frontend for **Resonance**. This application provides a stunning, interactive interface for users to explore knowledge graphs generated from their favorite podcasts.

## 🚀 Overview

Resonance Client is designed to move beyond simple lists, offering a dynamic, spacial way to navigate information using interactive graphs.

## ✨ Key Features

- **Interactive Knowledge Graphs**:
  - Visual exploration of ideas using the `graphify` package.
  - physics-based node interactions.
- **Deep Dive**:
  - **Node Details**: Tap any node to see a summary, listen to the specific audio segment, or view related nodes.
  - **Filter by Categories or Speakers**: Filter the graph to see only nodes related to specific categories or speakers.
  - **Cycle Granularity**: Cycle through different levels of granularity in the graph for deeper or broader exploration.
  - **Chat**: Ask questions to specific speakers using Retrieval Augmented Context from the podcast.
- **Responsive Design**:
  - Optimized for Web and Mobile screens.
  - Adaptive layouts and typography using `auto_size_text` and `mesh_gradient` for an amazing feel.
- **User Space**:
  - Authentication (Log in with Google).
  - Bookmark/Save interesting nodes for later review.
  - View list of added podcasts.

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [Riverpod](https://riverpod.dev/) (w/ Code Gen)
- **Routing**: [GoRouter](https://pub.dev/packages/go_router)
- **Networking**: [Serverpod](https://serverpod.dev/)
- **Visualization**: `graphify` (Custom package)
- **Styling**: [Google Fonts](https://fonts.google.com/), [Animated Text Kit](https://pub.dev/packages/animated_text_kit), [Mesh Gradients](https://pub.dev/packages/mesh_gradient).

## ⚡ Getting Started

### Prerequisites

- **Flutter SDK**: Version 3.22.0 or higher.
- **Resonance Server**: The backend must be running locally or accessible remotely.

### Setup & Run

1.  **Get Dependencies**:
    ```bash
    flutter pub get
    ```

2.  **Generate Code**:
    Run build_runner to generate Riverpod providers.
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

3.  **Run the App**:
    ```bash
    flutter run -d chrome
    ```

## 📂 Project Structure

- `lib/presentation`: UI components, pages, and widgets.
- `lib/application`: Service providers.
- `packages/graphify`: Internal package for graph visualization.
