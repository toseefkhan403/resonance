import 'package:resonance_client/resonance_client.dart';
import 'package:resonance_flutter/application/serverpod_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversation_service.g.dart';

class ConversationService {
  ConversationService(this._client);
  final Client _client;

  Future<List<Speaker>> listSpeakers() {
    return _client.conversation.listSpeakers();
  }

  Stream<String> askQuestion(String text, Speaker speaker) {
    return _client.conversation.askQuestion(text, speaker);
  }
}

@Riverpod(keepAlive: true)
ConversationService conversationService(Ref ref) {
  final client = ref.watch(serverpodClientProvider);
  return ConversationService(client);
}
