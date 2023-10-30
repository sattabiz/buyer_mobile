import 'package:PaletPoint/model/invoice_model.dart';
import 'package:PaletPoint/model/proposal_model.dart';
import 'package:PaletPoint/model/shipment_model.dart';
import 'package:PaletPoint/view/proposal_view/proposal_view.dart';
import 'package:PaletPoint/view_model/get_notifications_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swipe/swipe.dart';
import '../model/order_model.dart';
import '../utils/widget_helper.dart';
import '../view_model/confirm_order_view_model.dart.dart';
import '../view_model/current_user_view_model.dart';
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
    final chatId = ref.watch(messageRoomIdProvider);
    ref.watch(getCurrentUserInfoProvider);
    double witdh = MediaQuery.of(context).size.width;
    return Swipe(
      onSwipeLeft: () async{
        ref.refresh(getProposalProvider);
        context.go('/proposal');
      },
      child: RefreshIndicator(
        onRefresh: () async{
          ref.refresh(getNotificationProvider);
        },
        child: notificationListAsyncValue.when(
          data: (data) {
            if(data.isEmpty){
              return Container(
                  width: witdh,
                  color: Theme.of(context).colorScheme.onPrimary,
                  alignment: Alignment.center,
                  child: Text(
                    FlutterI18n.translate(context, 'tr.home.empty_notification'),
                  )
                );
            }else{
              return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                if (data[index] is OrderModel) {
                  return IndexListTile(
                    title: data[index].messageAppNotification == true ? "Yeni Mesaj" : FlutterI18n.translate(context, 'tr.order.${data[index].state}'),
                    subtitle: FlutterI18n.translate(context, 'tr.order.order_no'),
                    subtitle2: data[index].id.toString(),
                    subtitle3:
                        FlutterI18n.translate(context, 'tr.order.order_date'),
                    subtitle4: formattedDate(data[index].orderDate.toString()),
                    width: 30,
                    svgPath: data[index].messageAppNotification == true ? "assets/svg/chat.svg" : 'assets/svg/flare.svg', //alertIconWithState(data[index].state) ?? ' ',
                    onTap: () async {
                      if(data[index].messageAppNotification == false){
                        ref.watch(getListCurrenciesProvider);
                        ref.read(messageIdProvider.notifier).state = 'order_id=${data[index].id}';
                        ref.read(createMessageMapProvider.notifier).state = {'order_id': data[index].id};
                        ref.read(chatBoxHeaderProvider.notifier).state = "Sipariş No: ${data[index].id}"; 
                        ref.read(orderIdProvider.notifier).state=data[index].id;        //read orderId for confirm order post service
                        ref.read(orderIndexProvider.notifier).state = data[index];            //read index for order-detail page
                        ref.watch(getOrderProvider);
                        ref.watch(getMessageProvider);
                        ref.watch(getNotificationProvider);
    /*                       final logoutViewModel =
                        ref.read(logoutViewModelProvider.notifier);
                        await logoutViewModel.logout(); */
                        context.goNamed('order_detail', 
                        pathParameters: {'orderId' : data[index].id.toString()});
                      }else if(data[index].messageAppNotification == true){
                        ref.watch(getListCurrenciesProvider);
                        ref.read(messageIdProvider.notifier).state = 'order_id=${data[index].id}';
                        ref.read(createMessageMapProvider.notifier).state = {'order_id': data[index].id};
                        ref.read(chatBoxHeaderProvider.notifier).state = "Sipariş No: ${data[index].id}"; 
                        ref.read(orderIdProvider.notifier).state=data[index].id;        //read orderId for confirm order post service
                        ref.read(orderIndexProvider.notifier).state = data[index];            //read index for order-detail page
                        ref.watch(getOrderProvider);
                        ref.watch(getNotificationProvider);
                        await ref.watch(getMessageProvider);
                        ref.read(messagePipeProvider.notifier).state = 1;
                        //await ref.refresh(webSocketProvider);
                        await ref.watch(webSocketProvider);
                        // ignore: use_build_context_synchronously
                        context.goNamed('order_chat', pathParameters: {                       
                          'orderId': data[index].id.toString(),
                          'chatId': '$chatId'
                        }); 
                      }
    
                    },
                  );
                } else if (data[index] is ProposalModel) {
                  return IndexListTile(
                    title: data[index].messageAppNotification == true ? "Yeni Mesaj" : "Teklif No: ${data[index].proposalId.toString()}", //"Teklif No: ${data[index].proposalId.toString()}",
                    subtitle: data[index].messageAppNotification == true ? "Teklif No: ${data[index].proposalId.toString()}": data[index].demandListName!, //proposalName gelecek
                    svgPath: data[index].messageAppNotification == true ? "assets/svg/chat.svg" : 'assets/svg/alert_error.svg' ,   //'assets/svg/alert_error.svg'
                    // trailing: const Counter(),
                    onTap: () async {
                      if(data[index].messageAppNotification == false){
                        ref.read(messageIdProvider.notifier).state = 'proposal_id=${data[index].proposalId}';
                        ref.read(createMessageMapProvider.notifier).state = {'proposal_id': data[index].proposalId};
                        ref.read(chatBoxHeaderProvider.notifier).state = "Teklif No: ${data[index].proposalId}";
                        ref.read(proposalIndexProvider.notifier).state = data[index];
                        ref.watch(getListCurrenciesProvider);
                        ref.refresh(formItemProvider);
                        ref.watch(getMessageProvider);
                        context.goNamed('proposal_detail', pathParameters: {'proposalId' : data[index].proposalId.toString()});
                      }else if(data[index].messageAppNotification == true){
                        ref.read(messageIdProvider.notifier).state = 'proposal_id=${data[index].proposalId}';
                        ref.read(createMessageMapProvider.notifier).state = {'proposal_id': data[index].proposalId};
                        ref.read(chatBoxHeaderProvider.notifier).state = "Teklif No: ${data[index].proposalId}";
                        ref.read(proposalIndexProvider.notifier).state = data[index];
                        await ref.watch(getMessageProvider);
                        ref.read(messagePipeProvider.notifier).state = 1;
                        //await ref.refresh(webSocketProvider);
                        await ref.watch(webSocketProvider);
                        // ignore: use_build_context_synchronously
                        context.goNamed('proposal_chat', pathParameters: {
                          'proposalId': data[index].proposalId.toString(),
                          'chatId': '$chatId'
                        }); 
                      }
                    },
                  );
                } else if(data[index] is InvoiceModel){
                  return IndexListTile(
                    title: "Yeni Mesaj", //FlutterI18n.translate(context, 'tr.invoice.${data[index].state}'),
                    subtitle: FlutterI18n.translate(context, 'tr.invoice.invoice_no'),
                    subtitle2: data[index].invoiceNo.toString(),
                    subtitle3: FlutterI18n.translate(context, 'tr.invoice.invoice_date'),
                    subtitle4: formattedDate(data[index].invoiceDate.toString()),
                    width: 100,
                    svgPath: data[index].messageAppNotification == true ? "assets/svg/chat.svg" : 'assets/svg/alert_error.svg',
                    onTap: () async {
                      if(data[index].messageAppNotification == false){
                        ref.read(messageIdProvider.notifier).state = 'invoice_id=${data[index].invoiceId}';
                        ref.read(createMessageMapProvider.notifier).state = {'invoice_id': data[index].invoiceId};
                        ref.read(chatBoxHeaderProvider.notifier).state = "Fatura No: ${data[index].invoiceId}";
                        ref.watch(getInvoicesProvider);
                        ref.read(invoiceIndexProvider.notifier).state = data[index];
                        ref.read(invoiceIdProvider.notifier).state=data[index].invoiceId; 
                        ref.watch(getMessageProvider);
                        context.goNamed('invoice_detail', pathParameters: {'invoiceId' : data[index].invoiceId.toString()});
                      }else if(data[index].messageAppNotification == true){
                        ref.read(messageIdProvider.notifier).state = 'invoice_id=${data[index].invoiceId}';
                        ref.read(createMessageMapProvider.notifier).state = {'invoice_id': data[index].invoiceId};
                        ref.read(chatBoxHeaderProvider.notifier).state = "Fatura No: ${data[index].invoiceId}";
                        ref.watch(getInvoicesProvider);
                        ref.read(invoiceIndexProvider.notifier).state = data[index];
                        ref.read(invoiceIdProvider.notifier).state=data[index].invoiceId; 
                        await ref.watch(getMessageProvider);
                        ref.read(messagePipeProvider.notifier).state = 1;
                        await ref.watch(webSocketProvider);
                        // ignore: use_build_context_synchronously
                        context.goNamed('invoice_chat', pathParameters: {
                          'invoiceId' : data[index].invoiceId.toString(),
                          'chatId' : '$chatId'
                        });
                      }
                    },
                  );
                } else if(data[index] is ShipmentModel){
                  return IndexListTile(
                    title: "Yeni Mesaj", /* FlutterI18n.translate(context, 'tr.shipment.shipment_no ${data[index].shipmentId}'), */ 
                    subtitle: FlutterI18n.translate(context, 'tr.shipment.shipment_no'),                        //duzeltilecek
                    subtitle2: data[index].shipmentId.toString(),
                    svgPath: data[index].messageAppNotification == true ? "assets/chat.svg" : 'assets/svg/alert_error.svg',            //duzeltilecek
                    width: 100,
                    onTap: () async{
                      ref.read(messageIdProvider.notifier).state = 'shipment_id=${data[index].shipmentId}';
                        ref.read(createMessageMapProvider.notifier).state = {'shipment_id': data[index].shipmentId};
                        ref.read(chatBoxHeaderProvider.notifier).state = "Sevkiyat No: ${data[index].shipmentId}";
                        await ref.watch(getMessageProvider);
                        ref.read(messagePipeProvider.notifier).state = 1;
                        await ref.watch(webSocketProvider);
                        // ignore: use_build_context_synchronously
                        context.goNamed('invoice_ready_chat',
                        pathParameters: {
                          'chatId': '$chatId'
                        }
                      );
                    },
                  );
                }
              },
             );
            }
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
