import 'package:buyer_mobile/view_model/get_order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widget/index_list_tile.dart';

class OrderView extends ConsumerWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) => IndexListTile(
        title: 'Headline',
        subtitle: 'Subtitle',
        svgPath: 'assets/alert.svg',
        trailing: const Icon(
          Icons.shape_line
          ),
        onTap: () {
          ref.watch(getOrderProvider);
          context.go('/order/detail');
        }, //context.go('/order/detail'),
      ),
    );
  }
}
