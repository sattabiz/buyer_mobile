import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_bar/top_app_bar_centered.dart';

class ChatMessage {
  String body;
  int userID;
  String createdAt;
  String user;

  ChatMessage({
    required this.body,
    required this.userID,
    required this.createdAt,
    required this.user,
  });
}

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

  void scrollToMaxExtent() {
    messageController.addListener(() {
      if (messageController.position.atEdge) {
        if (messageController.position.pixels == 0) {
          print('Top');
        } else {
          print('Bottom');
        }
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      messageController.animateTo(
        messageController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeIn,
      );
    });
  }

  void onSubmitted(String value) {
    setState(() {
      liveChats.add(ChatMessage(
          body: value, userID: 1, createdAt: "22:01", user: "Bilgesu"));
      textEditingController.clear();
      scrollToMaxExtent();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<ChatMessage> liveChats = [
    ChatMessage(
        body: "Siparis yolda", userID: 1, createdAt: "22:01", user: "Atakan"),
    ChatMessage(
        body: "Elinizde baska urun var mi?",
        userID: 2,
        createdAt: "22:02",
        user: "Bilgesu"),
    ChatMessage(body: "aaa", userID: 1, createdAt: "22:02", user: "Atakan"),
    ChatMessage(body: "deneme", userID: 0, createdAt: "22:02", user: "Bilgesu"),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        verticalDirection: VerticalDirection.down,
        children: [
          const TopAppBarCentered(
            title: "Teklif 1533",
            backRoute: "null",
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.onPrimary,
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: ListView.builder(
                controller: messageController,
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
                            alignment: (liveChats[index].userID == 1
                                ? Alignment.topRight
                                : Alignment.topLeft),
                            child: Container(
                              constraints:
                                  BoxConstraints.tightFor(width: width * 0.6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(8),
                                  topRight: const Radius.circular(8),
                                  bottomLeft: (liveChats[index].userID == 1
                                      ? const Radius.circular(10)
                                      : const Radius.circular(0)),
                                  bottomRight: (liveChats[index].userID == 1
                                      ? const Radius.circular(0)
                                      : const Radius.circular(10)),
                                ),
                                color: (liveChats[index].userID == 1
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
                                            color: liveChats[index].userID == 1
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
          Container(
            width: width,
            height: 70,
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
                    cursorColor: Theme.of(context).colorScheme.onBackground,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.onPrimary,
                      constraints: const BoxConstraints(maxHeight: 40),
                      hintText: "Bir Mesaj Yazın...",
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                  onPressed: () {
                    onSubmitted(textEditingController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
