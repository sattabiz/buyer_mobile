import 'package:buyer_mobile/view/proposal_view/detail_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../view_model/message_controller/get_message_view_model.dart';
import '../../../view_model/message_controller/websocket_message_view_model.dart';
import '../../../view_model/proposal_controller/create_proposal_view_model.dart';
import '../chat_box.dart';

class TopAppBarLeft extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final IconData? icon;
  void Function()? backRoute;
  void Function()? chatRoute;

  TopAppBarLeft({
    Key? key,
    required this.title,
    required this.icon,
     this.backRoute,
     this.chatRoute,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        onPressed: () async{
          backRoute!();
          ref.refresh(formItemProvider);
        },
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: Theme.of(context).colorScheme.onSecondary),
      ),
      actions: [
        IconButton(
          icon: Icon(
            icon,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          onPressed: () async{
            chatRoute!();
            await ref.watch(getMessageProvider);
            ref.read(messagePipeProvider.notifier).state = 1;
            ref.watch(webSocketProvider);
          },
          //ref.watch(getMessageProvider);
        ),
      ],
    );
  }
}
