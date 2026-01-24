import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resonance_client/resonance_client.dart';
import 'package:resonance_flutter/presentation/controllers/conversation_controller.dart';

class ChatPanel extends ConsumerStatefulWidget {
  const ChatPanel({super.key});

  @override
  ConsumerState<ChatPanel> createState() => _ChatPanelState();
}

class _ChatPanelState extends ConsumerState<ChatPanel> {
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _chatController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        unawaited(
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          ),
        );
      }
    });
  }

  void _sendMessage() {
    final text = _chatController.text.trim();
    if (text.isNotEmpty) {
      unawaited(
        ref.read(conversationControllerProvider.notifier).sendMessage(text),
      );
      _chatController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final conversationState = ref.watch(conversationControllerProvider);

    ref
      ..listen(
        conversationControllerProvider.select((s) => s.messages.length),
        (_, _) => _scrollToBottom(),
      )
      ..listen(
        conversationControllerProvider.select((s) => s.messages.lastOrNull),
        (prev, next) {
          // scroll on new chunk if streaming
          if (conversationState.isStreaming) {
            _scrollToBottom();
          }
        },
      );

    if (conversationState.error != null) {
      return Center(
        child: Text('Conversation Error: ${conversationState.error}'),
      );
    }

    return Column(
      children: [
        _buildSpeakerList(conversationState),
        const Divider(height: 1),
        _buildChatArea(conversationState),
      ],
    );
  }

  Widget _buildSpeakerList(ConversationState state) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Select Speaker',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.speakers == null || state.speakers!.isEmpty
                ? const Center(child: Text('No speakers found'))
                : ListView.builder(
                    itemCount: state.speakers!.length,
                    itemBuilder: (context, index) {
                      final speaker = state.speakers![index];
                      return RadioListTile<Speaker>(
                        title: Text(speaker.name),
                        value: speaker,
                        // ignore: deprecated_member_use
                        groupValue: state.selectedSpeaker,
                        // ignore: deprecated_member_use
                        onChanged: (Speaker? value) {
                          ref
                              .read(conversationControllerProvider.notifier)
                              .selectSpeaker(value);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatArea(ConversationState state) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: state.messages.length,
              itemBuilder: (context, index) {
                final msg = state.messages[index];
                return Align(
                  alignment: msg.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 8),
                    constraints: const BoxConstraints(maxWidth: 240),
                    decoration: BoxDecoration(
                      color: msg.isUser
                          ? Theme.of(
                              context,
                            ).primaryColor.withValues(alpha: 0.1)
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg.text),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  offset: const Offset(0, -2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    enabled:
                        !state.isStreaming && state.selectedSpeaker != null,
                    decoration: const InputDecoration(
                      hintText: 'Ask a question...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: state.isStreaming
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.send),
                  onPressed: state.isStreaming || state.selectedSpeaker == null
                      ? null
                      : _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
