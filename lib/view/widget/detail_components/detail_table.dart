import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../view_model/get_order_view_model.dart';

class DetailTable extends ConsumerWidget {
 DetailTable({ Key? key }) : super(key: key);

  Map<int, Map<String, String>> products = {
    0: {
      'name': 'Ürün 1',
      'amount': '1 adet',
      'price': '110 ₺',
      'total': '100 ₺',
      'shippedAmount': "100",
    },
    1: {
      'name': 'Ürün 2',
      'amount': '10 adet',
      'price': '110 ₺',
      'total': '100 ₺',
      'shippedAmount': "20",
    },
    2: {
      'name': 'Ürün 3',
      'amount': '1 adet',
      'price': '110 ₺',
      'total': '100 ₺ ',
      'shippedAmount': "100",
    },
    3: {
      'name': 'Ürün 4',
      'amount': '1 adet',
      'price': '110 ₺',
      'total': '100 ₺ ',
      'shippedAmount': "100",
    },
    4: {
      'name': 'Ürün 5',
      'amount': '1 adet',
      'price': '110 ₺',
      'total': '100 ₺ ',
      'shippedAmount': "100",
    },
  };


  @override
  Widget build(BuildContext context, WidgetRef ref){
    final orderProducts = ref.watch(orderIndexProvider);
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

          ],
        ),

        for (var i = 0; i < orderProducts!.products!.length; i++)
          TableRow(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 5.0, top: 5.0),
                padding: EdgeInsets.only(left: 5.0),
                child: Text(
                  orderProducts.products![i].name.toString(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  )
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5.0, top: 5.0),
                alignment: Alignment.centerRight,
                child: Text(
                  orderProducts.products![i].amount.toString(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  )
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5.0, top: 5.0),
                alignment: Alignment.centerRight,
                child: Text(
                  orderProducts.products![i].price.toString(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  )
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5.0, top: 5.0),
                alignment: Alignment.centerRight,
                child: Text(
                  "000",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  )
                ),
              ),

          ],
        ),
      ],
    );
  }
}