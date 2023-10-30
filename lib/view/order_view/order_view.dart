import 'package:PaletPoint/view_model/get_order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:swipe/swipe.dart';
import '../../utils/widget_helper.dart';
import '../../view_model/confirm_order_view_model.dart.dart';
import '../../view_model/message_controller/create_message_view_model.dart';
import '../../view_model/message_controller/get_message_view_model.dart';
import '../proposal_view/proposal_view.dart';
import '../widget/app_bar/top_app_bar_left.dart';
import '../widget/index_list_tile.dart';


class OrderView extends ConsumerWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderListAsyncValue = ref.watch(getOrderProvider);
    return Swipe(
      onSwipeLeft: () {
        context.go('/invoice');
      },
      onSwipeRight: () => context.go('/proposal'),
      child: RefreshIndicator(
        onRefresh: () async{
          ref.refresh(getOrderProvider);
        },
        child: orderListAsyncValue.when(
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
                trailing: (() {                                                                               //for widget notification icons
                  if (data[index].messageNotification == true) {
                    return SvgPicture.asset(                  
                      "assets/svg/chat.svg"
                    );
                  } else {
                    return SizedBox();
                  }
                })(),
                onTap: () async{
                  ref.read(messageIdProvider.notifier).state = 'order_id=${data[index].id}';
                  ref.read(createMessageMapProvider.notifier).state = {'order_id': data[index].id};
                  ref.read(chatBoxHeaderProvider.notifier).state = "Sipariş No: ${data[index].id}";   //for chat box header name
                  ref.read(orderIdProvider.notifier).state=data[index].id;        //read orderId for confirm order post service
                  ref.read(orderIndexProvider.notifier).state = data[index];            //read index for order-detail page
                  ref.watch(getOrderProvider);                                          //get order data
                  ref.watch(getMessageProvider);                                        //get order messages
                  context.goNamed('order_detail', pathParameters: {'orderId' : data[index].id.toString()});
                  ref.read(messageIconProvider.notifier).state = data[index].messageNotification; //for product detail view' s Icon provider
                }, //context.go('/order/detail'),
              ),
            );
          },
          loading: () => Container(),
          error: (error, stack) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/login');  
            });
            return Text('An error occurred: $error');
          },
        ),
      ),
    );
  }
}
