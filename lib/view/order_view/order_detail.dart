import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../model/order_model.dart';
import '../../view_model/confirm_order_view_model.dart.dart';
import '../../view_model/get_order_view_model.dart';
import '../widget/app_bar/top_app_bar_left.dart';
import '../widget/detail_components/detail_table.dart';
import 'order_detail_info.dart';

class OrderDetail extends ConsumerWidget {
  const OrderDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {     //tasarima karar verilecek
    OrderModel? orderAsyncValue = ref.watch(orderIndexProvider);
  
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: TopAppBarLeft(
        title: "Sipariş No: ${orderAsyncValue!.id.toString()}",
        route: '/order',
        icon: Icons.chat_bubble_outline,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).colorScheme.onSecondary,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  FlutterI18n.translate(context, 'tr.detail_info.order.${orderAsyncValue.state}'),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                ),
              ),
              SizedBox(
                width: width,
                child: OrderDetailInfo(
                  row1: orderAsyncValue.orderDate.toString().split('T')[0],
                  row2: orderAsyncValue.deliveryDate.toString().split('T')[0] ?? "API Null deger",                   //null gelmesine gore ayarlamak lazim  
                  row3: orderAsyncValue.paymentDueDate.toString(),
                  row4: orderAsyncValue.includeShipmentCost == true? "Alıcı" :"Satıcı",
                  row5: orderAsyncValue.paymentType ?? "API Null deger",                    //null gelmesine gore ayarlamak lazim
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                width: width,
                padding: const EdgeInsets.all(5.0),
                child: DetailTable(
                  products: orderAsyncValue.products!
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/order_detail/ready'),
          // print();
        
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.bottomStart,
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () async{
            ref.watch(confirmOrderProvider);
            ref.refresh(getOrderProvider);
            //context.go('/order/detail');   //order sayfasina geri dondurulmesi lazim
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).colorScheme.primary),
            fixedSize: MaterialStateProperty.all<Size>(const Size(100, 30)),
          ),
          child: Text(
            'Onayla',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ),
        OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: Theme.of(context).colorScheme.error,
              ),
              fixedSize: const Size(100, 30),
            ),
            child: Text(
              'Ret',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ))
      ],
    );
  }
}
