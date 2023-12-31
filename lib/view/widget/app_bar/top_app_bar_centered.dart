import 'package:PaletPoint/view_model/get_invoice_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../view_model/message_controller/websocket_message_view_model.dart';

class TopAppBarCentered extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final String? backRoute;
  final bool? openDrawer;

  const TopAppBarCentered({
    Key? key,
    required this.title,
    this.backRoute,
    this.openDrawer = false
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        onPressed: () async {
          backRoute == "null" ? context.pop() : context.go(backRoute!);
          ref.read(messagePipeProvider.notifier).state = 2;
          ref.watch(webSocketProvider);
          ref.refresh(getInvoicesProvider);
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
        openDrawer == true
        ? Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: Theme.of(context).colorScheme.onPrimary,
            )
          );
        })
        : Container(),
      ],
    );
  }
}
