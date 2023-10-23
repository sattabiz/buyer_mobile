import 'package:PaletPoint/utils/widget_helper.dart';
import 'package:PaletPoint/view_model/SupplierGenerateMultiOrder/multi_order_invoice_view_model.dart';
import 'package:PaletPoint/view_model/get_address_view_model.dart';
import 'package:PaletPoint/view_model/get_shipment_view_model.dart';
import 'package:PaletPoint/view_model/invoice_paid_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../view_model/get_invoice_view_model.dart';
import '../../view_model/message_controller/create_message_view_model.dart';
import '../../view_model/message_controller/get_message_view_model.dart';
import '../proposal_view/proposal_view.dart';
import '../widget/index_list_tile.dart';

class InvoiceView extends ConsumerWidget {
  const InvoiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoiceListAsyncValue = ref.watch(getInvoicesProvider);
    return RefreshIndicator(
      onRefresh: () async{
        ref.refresh(getInvoicesProvider);
      },
      child: invoiceListAsyncValue.when(
        data: (data) {
          return Stack(
            children: [
              ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => IndexListTile(
                  title: FlutterI18n.translate(context, 'tr.invoice.${data[index].state}'),
                  subtitle: FlutterI18n.translate(context, 'tr.invoice.invoice_no'),
                  subtitle2: data[index].invoiceNo,
                  subtitle3: FlutterI18n.translate(context, 'tr.invoice.invoice_date'),
                  subtitle4: formattedDate(data[index].invoiceDate.toString()),
                  width: 100,
                  svgPath: statusIconMap[data[index].state] ?? ' ',
                  trailing: (() {                                                                               //for widget notification icons
                    if (data[index].messageNotification == true) {
                      return SvgPicture.asset(                  
                        "assets/svg/chat.svg"
                      );
                    } else {
                      return const SizedBox();
                    }
                  })(),
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
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(20.0),
                child: FloatingActionButton.extended(
                  label: Text(
                    FlutterI18n.translate(context, 'tr.invoice.invoice_btn'),
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: () async{
                    ref.watch(getShipmentProvider);
                    ref.read(multiOrderProvider.notifier).removeAllFormItems();
                    context.go('/invoice/invoice_ready');
                  },
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              )
            ],
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
  }
}
