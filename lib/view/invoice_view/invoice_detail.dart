import 'package:buyer_mobile/view_model/get_invoice_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/widget_helper.dart';
import '../widget/app_bar/top_app_bar_left.dart';
import '../widget/detail_components/detail_info.dart';
import '../widget/detail_components/detail_table.dart';
import '../widget/detail_components/detail_table_panel.dart';

class InvoiceDetail extends ConsumerWidget {
  const InvoiceDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    final invoiceList = ref.watch(invoiceIndexProvider);
    return Scaffold(
      appBar: TopAppBarLeft(
        title: 'Fatura: ${invoiceList.invoiceNo}',
        icon: Icons.chat_bubble_outline,
        route: '/invoice',
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
                  "Yolda",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color:
                        Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
              SizedBox(
                width: width,
                child: DetailInfo(
                  className: 'invoice',
                  row1: invoiceList.invoiceDate.toString().split('T')[0],
                  row2: invoiceList.paymentDate.toString().split('T')[0],
                  row3: invoiceList.orderId.toString(),
                  row4: invoiceList.paymentType,
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                width: width,
                padding: const EdgeInsets.all(5.0),
                child: DetailTable(
                  products: invoiceList.products!
                ),
              ),
              SizedBox(
                width: width,
                height: 100,
                child: DetailTablePanel(
                  productList: productList, 
                  isFileAttached: false, 
                  isPending: true
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
