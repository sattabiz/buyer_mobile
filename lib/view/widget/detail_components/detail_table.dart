import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/widget_helper.dart';


class DetailTable extends ConsumerWidget {
  final List products;
  final int id;
  final String className;
  const DetailTable({ 
    Key? key,
    required this.products,
    required this.id,
    required this.className,
   }) : super(key: key);

  Widget isImageEmpty(BuildContext context, int i, List products) {
    if (products[i].productsProposalFiles.values.isNotEmpty) {
      return IconButton(
      padding: const EdgeInsets.only(bottom: 20),
      onPressed: () {
        if(className == "proposal"){
          context.goNamed('proposal_image', pathParameters: {
            'proposalId': id.toString(),
            'imageUrl': products[i].productsProposalFiles.values.first,
          });
        }
        else if(className == "order"){
          context.goNamed('order_image', pathParameters: {
            'orderId': id.toString(),
            'imageUrl': products[i].productsProposalFiles.values.first,
          });
        }else{
          context.goNamed('invoice_image', pathParameters: {
            'invoiceId': id.toString(),
            'imageUrl': products[i].productsProposalFiles.values.first,
          });
        }
      },
      icon: Icon(
        Icons.image_outlined,
        size: 17,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      );
    } else {
      return const SizedBox.shrink();
   }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return Table(
      border: TableBorder(
        bottom: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1.0,
        ),
      ),
      columnWidths: const {
        0: FlexColumnWidth(0.4),
        1: FlexColumnWidth(0.2),
        2: FlexColumnWidth(0.2),
        3: FlexColumnWidth(0.2),
        4: FlexColumnWidth(0.1),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant,
                width: 1.0,
              ),
            ),
          ),
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                FlutterI18n.translate(context, 'tr.detail_table.row_1'),
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                )
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              alignment: Alignment.centerRight,
              child: Text(
                FlutterI18n.translate(context, 'tr.detail_table.row_2'),
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                )
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              alignment: Alignment.centerRight,
              child: Text(
                FlutterI18n.translate(context, 'tr.detail_table.row_3'),
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                )
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              alignment: Alignment.centerRight,
              child: Text(
                FlutterI18n.translate(context, 'tr.detail_table.row_4'),
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                )
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              alignment: Alignment.centerRight,
              child: Text(
                FlutterI18n.translate(context, 'tr.detail_table.row_6'),
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                )
              ),
            ),
          ],
        ),
        for (var i = 0; i < products.length; i++)
          TableRow(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 5.0, top: 5.0),
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  products[i].name.toString(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  )
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5.0, top: 5.0),
                alignment: Alignment.centerRight,
                child: Text(
                  products[i].amount.toString(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  )
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5.0, top: 5.0),
                alignment: Alignment.centerRight,
                child: Text(
                  products[i].price.toString() == "null"? "-" :"${products[i].price.toString()} ${getCurrencySymbol(products[i].currencyCode.toString())}",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  )
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5.0, top: 5.0),
                alignment: Alignment.centerRight,
                child: Text(
                  products[i].amount.toString() == 'null' || products[i].price.toString() == "null" ? '-' 
                  : "${calcuteAmount(products[i].amount.toString(), products[i].price.toString())} ${getCurrencySymbol(products[i].currencyCode.toString())}",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  )
                ),
              ),
              isImageEmpty(context, i, products)
          ],
        ),
      ],
    );
  }
  
}