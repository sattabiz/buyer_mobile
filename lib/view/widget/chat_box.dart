import 'package:buyer_mobile/model/get_current_user_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../view_model/current_user_view_model.dart';
import '../../view_model/message_controller/create_message_view_model.dart';
import '../../view_model/message_controller/list_messages_view_model.dart';
import 'app_bar/top_app_bar_centered.dart';

final readMessageProvider = StateProvider<String?>((ref) => '');

class ChatBox extends ConsumerStatefulWidget {
  final String id;
  const ChatBox({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatBoxState();
}

class _ChatBoxState extends ConsumerState<ChatBox> {
  TextEditingController textEditingController = TextEditingController();
  ScrollController messageController = ScrollController();

  void onSubmitted(String value) {
    FocusScope.of(context).unfocus(); //close the keyboard
    textEditingController.clear();
    ref.read(readMessageProvider.notifier).state = value;
    ref.watch(createMessageProvider);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    messageController.dispose();
    super.dispose();
  }

  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final liveChats = ref.watch(liveChatProvider).reversed.toList();
    // liveChats.reversed.toList();
    CurrentUserInfoModel userInfo = ref.watch(userIdProvider);
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        verticalDirection: VerticalDirection.down,
        children: [
          TopAppBarCentered(
            title: ref.watch(chatBoxHeaderProvider)!,
            backRoute: "null",
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.onPrimary,
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: ListView.builder(
                controller: messageController,
                reverse: true,
                itemCount: liveChats.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return liveChats[index].userID == 0
                      ? Container(
                          margin: const EdgeInsets.only(bottom: 15, top: 15),
                          child: Text(
                            "${liveChats[index].createdAt.toString()}   ${liveChats[index].body.toString()}",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontStyle: FontStyle.italic,
                                    ),
                          ))
                      : Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Align(
                            alignment:
                                (liveChats[index].userID == userInfo.company!.id
                                    ? Alignment.topRight
                                    : Alignment.topLeft),
                            child: Container(
                              constraints:
                                  BoxConstraints.tightFor(width: width * 0.6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(8),
                                  topRight: const Radius.circular(8),
                                  bottomLeft: (liveChats[index].userID ==
                                          userInfo.company!.id
                                      ? const Radius.circular(10)
                                      : const Radius.circular(0)),
                                  bottomRight: (liveChats[index].userID ==
                                          userInfo.company!.id
                                      ? const Radius.circular(0)
                                      : const Radius.circular(10)),
                                ),
                                color: (liveChats[index].userID ==
                                        userInfo.company!.id
                                    ? Theme.of(context)
                                        .colorScheme
                                        .inversePrimary
                                        .withOpacity(0.4)
                                    : Theme.of(context)
                                        .colorScheme
                                        .surfaceVariant),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      liveChats[index].user.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: liveChats[index].userID ==
                                                    userInfo.company!.id
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .secondary
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .onSurfaceVariant,
                                          ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      liveChats[index].body.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.2,
                                            height: 1.5,
                                          ),
                                      maxLines: double.maxFinite.floor(),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      liveChats[index].createdAt.toString(),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                },
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              width: width,
              height: 90,
              color: Theme.of(context).colorScheme.secondaryContainer,
              padding: const EdgeInsets.only(
                  top: 15.0, bottom: 15.0, right: 5.0, left: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: width * 0.8,
                    child: TextField(
                      controller: textEditingController,
                      // focusNode: focusNode,
                      // autofocus: true,
                      cursorColor: Theme.of(context).colorScheme.onBackground,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.onPrimary,
                        constraints: const BoxConstraints(maxHeight: 48),
                        hintText: "Bir Mesaj Yazın...",
                        hintStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.only(left: 10, right: 10),
                      ),
                    ),
                  ),
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    icon: Icon(
                      Icons.send,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      size: 35,
                    ),
                    onPressed: () async {
                      if (textEditingController.text != "") {
                        onSubmitted(textEditingController.text);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
