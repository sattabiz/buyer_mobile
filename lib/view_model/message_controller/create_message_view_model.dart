import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/api_url.dart';
import '../../service/post_service.dart';
import '../../view/widget/chat_box.dart';
import '../get_notifications_view_model.dart';

final createMessageProvider = FutureProvider.autoDispose((ref) async {
  final apiService = PostService();
  Response response;
  final createMessageMapAsyncValue =
       ref.watch(createMessageMapProvider);

  final readMessageMapAsyncValue =
       ref.watch(readMessageProvider);
  
createMessageMapAsyncValue!['body'] = readMessageMapAsyncValue;

  try {
    response = await apiService.post(url: ApiUrls.createMessage, data: createMessageMapAsyncValue);
    ref.refresh(getNotificationProvider);   
  } catch (e) {
    rethrow;
  }


  return response.statusCode;
});

final createMessageMapProvider = StateProvider<Map?>((ref) => {})  ;
final chatBoxHeaderProvider = StateProvider<String?>((ref) => "")  ;