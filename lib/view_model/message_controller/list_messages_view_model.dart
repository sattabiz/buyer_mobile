import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/message_model.dart';

final liveChatProvider = StateNotifierProvider.autoDispose<MessageNotifier, List<Message>>((ref) {
  return MessageNotifier();
});

class MessageNotifier extends StateNotifier<List<Message>> {
  MessageNotifier() : super([]);
  
  
  void addMessage(Message message) {
    state = [...state, message];

  }

  void removeMessage(int messageId) {
    state = state.where((message) => message.id != messageId).toList();
  }
}
