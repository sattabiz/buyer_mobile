import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import '../../utils/widget_helper.dart';
import '../widget/app_bar/dialog_app_bar.dart';

class ReadyForShipDetail extends StatefulWidget {
  const ReadyForShipDetail({ Key? key }) : super(key: key);

  @override
  _ReadyForShipDetailState createState() => _ReadyForShipDetailState();
}

class _ReadyForShipDetailState extends State<ReadyForShipDetail> {

  ScrollController _scrollController = ScrollController();

  Map<int, Map<String, String>> products = {
    0: {
      'name': 'Ürün 1111111111111111111111111111111111111',
      'amount': '1 adet',
      'price': '110 ₺',
      'total': '100 ₺',
      'unit': 'Adet',
    },
    1: {
      'name': 'Ürün 2',
      'amount': '10 adet',
      'price': '110 ₺',
      'total': '100 ₺',
      'unit': 'Adet',
    },
    2: {
      'name': 'Ürün 3',
      'amount': '1 adet',
      'price': '110 ₺',
      'total': '100 ₺ ',
      'unit': 'Adet',
    },
    3: {
      'name': 'Ürün 4',
      'amount': '10 adet',
      'price': '110 ₺',
      'total': '100 ₺',
      'unit': 'Adet',
    },
    4: {
      'name': 'Ürün 5',
      'amount': '1 adet',
      'price': '110 ₺',
      'total': '100 ₺ ',
      'unit': 'Adet',
    },
    5: {
      'name': 'Ürün 5',
      'amount': '1 adet',
      'price': '110 ₺',
      'total': '100 ₺ ',
      'unit': 'Adet',
    },
    6: {
      'name': 'Ürün 5',
      'amount': '1 adet',
      'price': '110 ₺',
      'total': '100 ₺ ',
      'unit': 'Adet',
    },
    7: {
      'name': 'Ürün 5',
      'amount': '1 adet',
      'price': '110 ₺',
      'total': '100 ₺ ',
      'unit': 'Adet',
    },
  };

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.onPrimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DialogAppBar(
            title: FlutterI18n.translate(context, 'tr.ready_for_ship.title'),
            route: '/order_detail',
          ),
          Flexible(
            child: ListView.builder(
              itemCount: products.length,
              shrinkWrap: true,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          products[index]!['name']!,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant
                          ),
                        ),
                      ),
                      Container(
                        width: 150,
                        margin: const EdgeInsets.only(left: 10.0),
                        child: TextField(
                          cursorColor: Theme.of(context).colorScheme.onBackground,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.onPrimary,
                            contentPadding: const EdgeInsets.only(left: 10.0, right: 5.0),
                            label: Text(
                              'Hazir Miktar',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            suffix: Text(products[index]!['unit']!),
                            suffixStyle: Theme.of(context).textTheme.bodySmall,
                            constraints: const BoxConstraints(maxHeight: 40), 
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.onSurfaceVariant
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color:
                                    Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            ),
          ),
          Container(
            margin: const EdgeInsets.all(30.0),
            child: Text(
              FlutterI18n.translate(context, 'tr.ready_for_ship.information'),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant
              ),
            ),
          )
        ],
      ),
    );
  }
}