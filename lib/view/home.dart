import 'package:buyer_mobile/model/invoice_model.dart';
import 'package:buyer_mobile/model/proposal_model.dart';
import 'package:buyer_mobile/model/shipment_model.dart';
import 'package:buyer_mobile/view/proposal_view/proposal_view.dart';
import 'package:buyer_mobile/view_model/get_notifications_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../model/order_model.dart';
import '../utils/widget_helper.dart';
import '../view_model/confirm_order_view_model.dart.dart';
import '../view_model/get_invoice_view_model.dart';
import '../view_model/get_order_view_model.dart';
import '../view_model/invoice_paid_view_model.dart';
import '../view_model/message_controller/create_message_view_model.dart';
import '../view_model/message_controller/get_message_view_model.dart';
import '../view_model/message_controller/websocket_message_view_model.dart';
import '../view_model/proposal_controller/create_proposal_view_model.dart';
import '../view_model/proposal_controller/get_proposal_view_model.dart';
import '../view_model/proposal_controller/list_currencies_view_model.dart';
import 'widget/index_list_tile.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationListAsyncValue = ref.watch(getNotificationProvider);
    return RefreshIndicator(
      onRefresh: () async{
        ref.refresh(getNotificationProvider);
      },
      child: notificationListAsyncValue.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              if (data[index] is OrderModel) {
                return IndexListTile(
                  title: FlutterI18n.translate(
                      context, 'tr.order.${data[index].state}'),
                  subtitle: FlutterI18n.translate(context, 'tr.order.order_no'),
                  subtitle2: data[index].id.toString(),
                  subtitle3:
                      FlutterI18n.translate(context, 'tr.order.order_date'),
                  subtitle4: formattedDate(data[index].orderDate.toString()),
                  width: 30,
                  svgPath: statusIconMap[data[index].state] ?? '',
                  trailing: const Icon(Icons.shape_line),
                  onTap: () async {
                    ref.read(messageIdProvider.notifier).state = 'order_id=${data[index].id}';
                    ref.read(createMessageMapProvider.notifier).state = {'order_id': data[index].id};
                    ref.read(chatBoxHeaderProvider.notifier).state = "Sipariş No: ${data[index].id}"; 
                    ref.read(orderIdProvider.notifier).state=data[index].id;        //read orderId for confirm order post service
                    ref.read(orderIndexProvider.notifier).state = data[index];            //read index for order-detail page
                    ref.watch(getOrderProvider);
                    ref.watch(getMessageProvider);
                    ref.watch(getNotificationProvider);
                    context.goNamed('order_detail', 
                    pathParameters: {'orderId' : data[index].id.toString()});
                  }, //context.go('/order/detail'),
                );
              } else if (data[index] is ProposalModel) {
                return IndexListTile(
                  title: "Teklif No: ${data[index].proposalId.toString()}",
                  subtitle: 'Subtitle', //proposalName gelecek
                  svgPath: statusIconMap[data[index].proposalState] ?? '',
                  // trailing: const Counter(),
                  //onTap: () => context.go('/proposal/detail'),
                  onTap: () async {
                    ref.read(messageIdProvider.notifier).state = 'proposal_id=${data[index].proposalId}';
                    ref.read(createMessageMapProvider.notifier).state = {'proposal_id': data[index].proposalId};
                    ref.read(chatBoxHeaderProvider.notifier).state = "Teklif No: ${data[index].proposalId}";
                    ref.read(proposalIndexProvider.notifier).state = data[index];
                    ref.watch(getListCurrenciesProvider);
                    ref.refresh(formItemProvider);
                    ref.watch(getMessageProvider);
                    if (data[index].proposalState == 'last_offer' || data[index].proposalState == 'proposal_stvs') {
                      context.go('/proposal');
                    } else {
                      context.goNamed('proposal_detail', pathParameters: {'proposalId' : data[index].proposalId.toString()});
                    }
                  },
                );
              } else if(data[index] is InvoiceModel){
                debugPrint("-------ASDASFAS-----------");
                return IndexListTile(
                  title: FlutterI18n.translate(context, 'tr.invoice.${data[index].state}'),
                  subtitle: FlutterI18n.translate(context, 'tr.invoice.invoice_no'),
                  subtitle2: data[index].invoiceNo,
                  subtitle3: FlutterI18n.translate(context, 'tr.invoice.invoice_date'),
                  subtitle4: formattedDate(data[index].invoiceDate.toString()),
                  width: 100,
                  svgPath: statusIconMap[data[index].state] ?? ' ',
                  trailing: const Icon(Icons.shape_line),
                  onTap: () async {
                    ref.read(messageIdProvider.notifier).state = 'invoice_id=${data[index].invoiceId}';
                    ref.read(createMessageMapProvider.notifier).state = {'invoice_id': data[index].invoiceId};
                    ref.read(chatBoxHeaderProvider.notifier).state = "Fatura No: ${data[index].invoiceId}";
                    ref.watch(getInvoicesProvider);
                    ref.read(invoiceIndexProvider.notifier).state = data[index];
                    ref.read(invoiceIdProvider.notifier).state=data[index].invoiceId; 
                    ref.watch(getMessageProvider);
                    context.goNamed('invoice_detail', pathParameters: {'invoiceId' : data[index].invoiceId.toString()});
                  },
                );
              } else if(data[index] is ShipmentModel){
                return IndexListTile(
                  title: FlutterI18n.translate(context, 'tr.shipment.shipment_no ${data[index].shipmentId}'), 
                  subtitle: '--------',                        //duzeltilecek
                  svgPath: 'assets/svg/flare.svg',            //duzeltilecek
                  width: 100,
                  trailing: const Icon(Icons.shape_line),
                  onTap: () {
                    ref.read(messageIdProvider.notifier).state = 'shipment_id=${data[index].shipmentId}';
                      ref.read(createMessageMapProvider.notifier).state = {'shipment_id': data[index].shipmentId};
                      ref.read(chatBoxHeaderProvider.notifier).state = "Sevkiyat No: ${data[index].shipmentId}";
                      ref.watch(getMessageProvider);
                      ref.read(messagePipeProvider.notifier).state = 1;
                      ref.watch(webSocketProvider);
                      context.goNamed('invoice_ready_chat',
                      pathParameters: {
                        'chatId': '1'
                      });
                  },
    
    
    
    
                   );
    
    
              }
            },
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
    );
    /* return Material(
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) => 
          IndexListTile(
            title: 'Headline',
            subtitle: 'Subtitle',
            svgPath: 'assets/svg/alert.svg',
            onTap: ()  => context.go('/home/detail')
          ),
      ),
    ); */
  }
}
