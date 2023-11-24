import 'package:PaletPoint/view_model/get_invoice_view_model.dart';
import 'package:PaletPoint/view_model/invoice_paid_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../view_model/message_controller/get_message_view_model.dart';
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
    final chatId = ref.watch(messageRoomIdProvider);
    return Column(
      children: [
        TopAppBarLeft(
          title: 'Fatura: ${invoiceList.invoiceNo}',
          backRoute: () => context.go('/invoice'),
          chatRoute: () => context.goNamed('invoice_chat', pathParameters: {
            'invoiceId' : invoiceList.invoiceId.toString(),
            'chatId' : '$chatId'
          }),
          refreshProvider: () async{
            ref.refresh(getInvoicesProvider);
            ref.refresh(getInvoicesProvider.future);
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
                    FlutterI18n.translate(
                        context, 'tr.invoice.${invoiceList.state}'),
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
                    row4: invoiceList.paymentType ?? 'null',
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
                  height: 140,
                  child: DetailTablePanel(
                    productList: invoiceList.products!, 
                    isFileAttached: false,
                    pageName: "invoice",
                  ),
                ),
                invoiceList.state == 'invoice_approved'
                ? Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: ()  {
                        ref.watch(invoicePaidProvider);
                        context.go('/invoice');
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).colorScheme.primary),
                        fixedSize:
                            MaterialStateProperty.all<Size>(const Size(100, 30)),
                      ),
                      child: Text(
                        FlutterI18n.translate(context, 'tr.invoice.paid__btn'),
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ),
                )
                : const SizedBox(),
              ],
            ),
          ),
        ),
    
      ],
    );
  }
}
