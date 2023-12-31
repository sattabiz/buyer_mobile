import 'dart:convert';
import 'package:PaletPoint/config/api_url.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../model/message_model.dart';
import '../../model/web_socket_message_model.dart';
import '../../storage/jwt_storage.dart';
import 'get_message_view_model.dart';
import 'list_messages_view_model.dart';

final webSocketProvider = StreamProvider<WebSocketChannel>((ref) async* {
  final _jwt = await jwtStorageService().getJwtData();
  String url = ApiUrls.webSocket(_jwt);
  final socket = WebSocketChannel.connect(Uri.parse(url));
  int? messageRoomIdAsyncValue = await ref.watch(messageRoomIdProvider);

  if (ref.watch(messagePipeProvider) == 1 && ref.watch(messageRoomIdProvider) != 0) {
    //for subscription
    final request = {
      "command": "subscribe",
      "identifier":
          "{\"channel\":\"MessageRoomChannel\",\"message_room_id\":$messageRoomIdAsyncValue}"
    };

    socket.sink.add(json.encode(request));

    await for (final message in socket.stream) {      
      if (message.toString().contains('"body"')) {
        //print('WebSocketProvider: Mesaj alındı: $message');
        WebSocketMessageModel webSocketAsyncValue = WebSocketMessageModel.fromMap(json.decode(message!));
        Message lastMessage = Message(
          id: webSocketAsyncValue.message!.id,
          body: webSocketAsyncValue.message!.body,
          createdAt: webSocketAsyncValue.message!.time,
          user: webSocketAsyncValue.message!.user,
          userID: webSocketAsyncValue.message!.userId,
        );
     
        ref.read(liveChatProvider.notifier).addMessage(lastMessage);
        yield socket;
      }
      yield socket;
    }
  } else if (ref.watch(messagePipeProvider) == 2) {
    //for unsubscription
    final request2 = {
      "command": "unsubscribe",
      "identifier":
          "{\"channel\":\"MessageRoomChannel\",\"message_room_id\":$messageRoomIdAsyncValue}"
    };
    
    socket.sink.add(json.encode(request2));
    socket.sink.close();
  
  
  }
});

final messagePipeProvider = StateProvider<int?>((ref) {
  //for open or close websocketProvider's subscription if-else part
  return 2;
});


