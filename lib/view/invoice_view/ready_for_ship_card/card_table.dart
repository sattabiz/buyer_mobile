import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardTable extends ConsumerStatefulWidget {
  const CardTable({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CardTableState();
}

class _CardTableState extends ConsumerState<CardTable> {
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

  bool _isAllSelected = false;

  List selectedProducts = [];

  bool selected = false;

  void onSelected(bool selected, int index, bool isAllSelected) {
    if ((selected == true) || (isAllSelected == true)) {
      selectedProducts.add(index);
    }
    else if (index == -1) {
      selectedProducts.addAll(products.keys.toList());
    }
    else {
      selectedProducts.remove(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(selectedProducts.toString());
    return Table(
      border: TableBorder(
        bottom: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 2.0,
        ),
      ),
      columnWidths: const {
        0: FlexColumnWidth(0.07),
        1: FlexColumnWidth(0.2),
        2: FlexColumnWidth(0.1),
        3: FlexColumnWidth(0.1),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant,
                width: 2.0,
              ),
            ),
          ),
          children: [
            Container(
              width: 20,
              height: 30,
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(bottom: 5.0),
              child: Checkbox(
                  value: _isAllSelected,
                  onChanged: (value) {
                    setState(() {
                      _isAllSelected = value!;
                      onSelected(value, -1, value);
                     });
                  }),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(
                  FlutterI18n.translate(context, 'tr.ready_for_ship.product'),
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      )),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(
                  FlutterI18n.translate(context, 'tr.ready_for_ship.amount'),
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      )),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(
                  FlutterI18n.translate(context, 'tr.ready_for_ship.ship'),
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      )),
            ),
          ],
        ),
        for (var i = 0; i < products.length; i++)
          TableRow(
            children: [
              Container(
                width: 20,
                height: 30,
                margin: const EdgeInsets.only(bottom: 5.0),
                alignment: Alignment.center,
                child: Checkbox(
                    value: selected,
                    onChanged: (value) {
                      setState(() {
                        selected = value!;
                        onSelected(selected, i, value);
                      });
                    }
                    ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8.0),
                alignment: Alignment.centerLeft,
                child: Text(products[i]!['name']!,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        )),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8.0),
                alignment: Alignment.center,
                child: Text(products[i]!['amount']!,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        )),
              ),
              Container(
                margin: const EdgeInsets.all(5.0),
                alignment: Alignment.center,
                child: TextFormField(
                  initialValue: products[i]!['shippedAmount']!,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
                  decoration: InputDecoration(
                    constraints: BoxConstraints(maxHeight: 25),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),

                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
