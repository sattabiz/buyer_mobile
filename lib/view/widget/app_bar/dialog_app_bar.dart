import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../view_model/SupplierGenerateMultiOrder/create_multi_order_invoice_view_model.dart';

class DialogAppBar extends ConsumerWidget {
  final String title;
  final String route;

  const DialogAppBar({
    Key? key,
    required this.title,
    required this.route,
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
          onPressed: () async{
            ref.watch(createMultiOrderInvoiceProvider);
          },
          child: Text(
            'Kaydet',
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
