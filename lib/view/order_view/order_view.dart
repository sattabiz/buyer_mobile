import 'package:buyer_mobile/view_model/get_order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../utils/widget_helper.dart';
import '../../view_model/confirm_order_view_model.dart.dart';
import '../widget/index_list_tile.dart';


class OrderView extends ConsumerWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderListAsyncValue = ref.watch(getOrderProvider);
    return orderListAsyncValue.when(
      data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) => IndexListTile(
            title: FlutterI18n.translate(context, 'tr.order.${data[index].state}'),
            subtitle: FlutterI18n.translate(context, 'tr.order.order_no'),
            subtitle2: data[index].id.toString(),
            subtitle3: FlutterI18n.translate(context, 'tr.order.order_date'),
            subtitle4: formattedDate(data[index].orderDate.toString()),
            width: 30,
            svgPath: statusIconMap[data[index].state] ?? '',
            trailing: const Icon(Icons.shape_line),
            onTap: () {
              ref.read(orderIdProvider.notifier).state=data[index].id;        //read orderId for confirm order post service
              ref.read(orderIndexProvider.notifier).state = data[index];            //read index for order-detail page
              ref.watch(getOrderProvider);
              context.go('/order/detail');
            }, //context.go('/order/detail'),
          ),
        );
      },
      loading: () => Container(),
      error: (error, stack) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, '/login');
        });
        return Text('An error occurred: $error');
      },
    );
  }
}
