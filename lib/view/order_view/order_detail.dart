import 'package:PaletPoint/view/order_view/ready_for_ship_detail.dart';
import 'package:PaletPoint/view/widget/detail_components/detail_table_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../model/order_model.dart';
import '../../view_model/confirm_order_view_model.dart.dart';
import '../../view_model/get_order_view_model.dart';
import '../../view_model/message_controller/get_message_view_model.dart';
import '../widget/app_bar/top_app_bar_left.dart';
import '../widget/detail_components/detail_table.dart';
import '../widget/detail_components/detail_table_panel.dart';
import 'order_detail_info.dart';

class OrderDetail extends ConsumerWidget {
  final String orderId;
  const OrderDetail({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //tasarima karar verilecek
    OrderModel? orderAsyncValue = ref.watch(orderIndexProvider);
    final chatId = ref.watch(messageRoomIdProvider);
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Column(
          children: [
            TopAppBarLeft(
              title: "Sipariş No: ${orderAsyncValue!.id.toString()}",
              backRoute: () => context.go('/order'),
              chatRoute: () => context.goNamed('order_chat', pathParameters: {
                'orderId': orderAsyncValue.id.toString(),
                'chatId': '$chatId'
              }),
              refreshProvider: () async{
                ref.refresh(getOrderProvider);
                ref.refresh(getOrderProvider.future);
              },
            ),
            SingleChildScrollView(
              child: Container(
                color: Theme.of(context).colorScheme.onSecondary,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        FlutterI18n.translate(context, 'tr.order.${orderAsyncValue.state}'),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: OrderDetailInfo(
                        row1: orderAsyncValue.orderDate.toString().split('T')[0],
                        row2: orderAsyncValue.deliveryDate
                            .toString()
                            .split('T')[0], //null gelmesine gore ayarlamak lazim
                        row3: orderAsyncValue.paymentDueDate.toString(),
                        row4: orderAsyncValue.includeShipmentCost == true
                            ? "Alıcı"
                            : "Satıcı",
                        row5: orderAsyncValue.paymentType ??
                            "Cari Hesap", //null gelmesine gore ayarlamak lazim
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      width: width,
                      padding: const EdgeInsets.all(5.0),
                      child: orderAsyncValue.state.toString() ==  'order_approved'
                      ? DetailTable(products: orderAsyncValue.products!)
                      : DetailTableOrder(products: orderAsyncValue.products!),
                    ),
                    orderAsyncValue.state.toString() ==  'order_approved'
                     ? SizedBox(
                         width: width,
                         child: DetailTablePanel(
                           productList: orderAsyncValue.products!,
                           isFileAttached: false,
                         )
                       )
                     : const SizedBox()
                  ],
                ),
              ),
            ),
          ],
        ),
        orderAsyncValue.state == 'order_confirmed'
        ? Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(20.0),
            child: FloatingActionButton.extended(
              label: Text(
                FlutterI18n.translate(context, 'tr.order.ship_btn'),
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Colors.white,
                ),
              ),
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () async{
                context.go('/order/detail/${orderAsyncValue.id}/ready');
                ref.read(createShipmentFormProvider.notifier).removeAllFormItems();
                ref.read(createShipmentOrderIdProvider.notifier).state = orderAsyncValue.id;
                for(int i = 0; i<orderAsyncValue.products!.length;i++){
                   ProductProposalsModel model = ProductProposalsModel();
                   model.productsProposalId = orderAsyncValue.products![i].productProposalId;
                   ref.read(createShipmentFormProvider.notifier).addFormItem(model);
                }
              },                  
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          )
        : const SizedBox(width: 0,),
        orderAsyncValue.state == 'order_approved'
        ?  Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () async {
                ref.watch(confirmOrderProvider);
                ref.refresh(getOrderProvider);
                context.go('/order'); //order sayfasina geri dondurulmesi lazim
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.primary),
                fixedSize:
                  MaterialStateProperty.all<Size>(const Size(100, 30)),
              ),
              child: Text(
                'Onayla',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          )
          : const SizedBox(width: 0,)
      ],
    );
  }
}


