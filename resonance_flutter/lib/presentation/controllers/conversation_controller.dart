// ignore_for_file: avoid_redundant_argument_values

import 'dart:async';

import 'package:resonance_client/resonance_client.dart';
import 'package:resonance_flutter/application/conversation_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversation_controller.g.dart';

class ChatMessage {
  const ChatMessage({required this.text, required this.isUser});

  final String text;
  final bool isUser;

  ChatMessage copyWith({String? text, bool? isUser}) {
    return ChatMessage(
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
    );
  }
}

class ConversationState {
  const ConversationState({
    this.speakers,
    this.selectedSpeaker,
    this.messages = const [],
    this.isStreaming = false,
    this.isLoading = true,
    this.error,
  });

  final List<Speaker>? speakers;
  final Speaker? selectedSpeaker;
  final List<ChatMessage> messages;
  final bool isStreaming;
  final bool isLoading;
  final String? error;

  ConversationState copyWith({
    List<Speaker>? speakers,
    Speaker? selectedSpeaker,
    List<ChatMessage>? messages,
    bool? isStreaming,
    bool? isLoading,
    String? error,
  }) {
    return ConversationState(
      speakers: speakers ?? this.speakers,
      selectedSpeaker: selectedSpeaker ?? this.selectedSpeaker,
      messages: messages ?? this.messages,
      isStreaming: isStreaming ?? this.isStreaming,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

@riverpod
class ConversationController extends _$ConversationController {
  @override
  ConversationState build() {
    unawaited(_loadSpeakers());
    return const ConversationState();
  }

  Future<void> _loadSpeakers() async {
    try {
      final service = ref.read(conversationServiceProvider);
      final speakers = await service.listSpeakers();

      state = state.copyWith(
        speakers: speakers,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  void selectSpeaker(Speaker? speaker) {
    state = state.copyWith(selectedSpeaker: speaker);
  }

  Future<void> sendMessage(String text) async {
    if (text.isEmpty || state.selectedSpeaker == null || state.isStreaming) {
      return;
    }

    final currentMessages = List<ChatMessage>.from(state.messages)
      ..add(ChatMessage(text: text, isUser: true))
      ..add(const ChatMessage(text: '...', isUser: false));

    state = state.copyWith(
      messages: currentMessages,
      isStreaming: true,
    );

    try {
      final service = ref.read(conversationServiceProvider);
      final stream = service.askQuestion(text, state.selectedSpeaker!);

      await for (final chunk in stream) {
        final messages = List<ChatMessage>.from(state.messages);
        if (messages.isNotEmpty && !messages.last.isUser) {
          final lastMsg = messages.last;
          messages.last = lastMsg.copyWith(text: lastMsg.text + chunk);
          state = state.copyWith(messages: messages);
        }
      }
    } catch (e) {
      final messages = List<ChatMessage>.from(state.messages)
        ..add(ChatMessage(text: 'Error: $e', isUser: false));
      state = state.copyWith(messages: messages);
    } finally {
      state = state.copyWith(isStreaming: false);
    }
  }
}
