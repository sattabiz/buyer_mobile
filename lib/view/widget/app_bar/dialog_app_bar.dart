import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../view_model/generate_multi_order_controller/create_multi_order_invoice_view_model.dart';
import '../../../view_model/create_shipment_record_view_model.dart';

class DialogAppBar extends ConsumerWidget {
  final String title;
  final String route;
  final String providerName;
  final String buttonName;
  final Function? onPressed;

  const DialogAppBar({
    Key? key,
    required this.title,
    required this.route,
    required this.providerName,
    required this.buttonName,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          onPressed: () => context.pop()
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      actions: [
        TextButton(
          onPressed: () => onPressed!(),
          child: Text(
            buttonName,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
      ],
    );
  }
}
