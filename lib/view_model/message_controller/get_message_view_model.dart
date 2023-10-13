import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/api_url.dart';
import '../../model/message_model.dart';
import '../../service/get_services.dart';
import '../../view/proposal_view/proposal_view.dart';
import 'list_messages_view_model.dart';
final messageRoomIdProvider = StateProvider<int>(
  (ref) {
    return 0;
  },
);

final getMessageProvider =
    FutureProvider.autoDispose<GetMessageModel>((ref) async {
  final apiService = ApiService();

  Response response;
  final messageId = ref.watch(messageIdProvider);
  try {
    response = await apiService.get(url: ApiUrls.getMessage(messageId!));
  } catch (e) {
    if (e is DioException) {
    }
    rethrow;
  }



  GetMessageModel getMessage = GetMessageModel.fromMap(response.data);
  if(getMessage.messages != null){
    for(Message message in getMessage.messages!){
      ref.read(liveChatProvider.notifier).addMessage(message);
    }

  }

  ref.read(messageRoomIdProvider.notifier).state = await getMessage.messageRoomId!;
  return getMessage;
});
