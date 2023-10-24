import 'package:PaletPoint/view_model/get_order_view_model.dart';
import 'package:PaletPoint/view_model/proposal_controller/get_proposal_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../../view_model/message_controller/get_message_view_model.dart';
import '../../../view_model/message_controller/websocket_message_view_model.dart';
import '../../../view_model/proposal_controller/create_proposal_view_model.dart';
final messageIconProvider = StateProvider<bool?>((ref) {
  return false;  
},);
class TopAppBarLeft extends ConsumerStatefulWidget implements PreferredSizeWidget {
  final String title;
  final void Function()? backRoute;
  final void Function()? chatRoute;
  final void Function()? refreshProvider;  //for get service refresh function

  TopAppBarLeft({
    Key? key,
    required this.title,    
     this.backRoute,
     this.chatRoute,
     this.refreshProvider
  }) : super(key: key);

  @override
  _TopAppBarLeftState createState() => _TopAppBarLeftState();
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
class _TopAppBarLeftState extends ConsumerState<TopAppBarLeft> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        onPressed: () async{
          widget.refreshProvider;
          widget.backRoute!();
          ref.refresh(formItemProvider);
          ref.refresh(getProposalProvider);
          ref.refresh(getOrderProvider);
        },
      ),
      title: Text(
        widget.title,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: Theme.of(context).colorScheme.onSecondary),
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            ref.watch(messageIconProvider) == true
              ? 'assets/svg/chat_bubble_unread.svg'
              : 'assets/svg/chat_bubble.svg',
          ),
          onPressed: () async{
            widget.chatRoute!();
            await ref.watch(getMessageProvider);
            ref.read(messagePipeProvider.notifier).state = 1;
            ref.watch(webSocketProvider);
            ref.read(messageIconProvider.notifier).state = false;
          },
          //ref.watch(getMessageProvider);
        ),
      ],
    );
  }
}
