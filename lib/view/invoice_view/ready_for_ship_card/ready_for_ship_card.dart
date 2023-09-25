import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:go_router/go_router.dart';

import 'card_table.dart';

class ReadyForShipCard extends StatefulWidget {
  const ReadyForShipCard({ Key? key }) : super(key: key);

  @override
  _ReadyForShipCardState createState() => _ReadyForShipCardState();
}

class _ReadyForShipCardState extends State<ReadyForShipCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      elevation: 2,
      margin: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
            
              ),
              color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.35),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      FlutterI18n.translate(context, 'tr.ready_for_ship.order_no'),
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant
                      ),
                    ),
                    Text(
                      '2566 ',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      FlutterI18n.translate(context, 'tr.ready_for_ship.tracking'),
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant
                      ),
                    ),
                    Text(
                      'Satici',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                    const SizedBox(width: 40),
                    Text(
                      FlutterI18n.translate(context, 'tr.ready_for_ship.payment'),
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant
                      ),
                    ),
                    Text(
                      "DBS",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant
                      ),
                    ),
                  ],
                ),
                
              ],
            ),

          ),
          const SizedBox(height: 5),
          SizedBox(
            child: const CardTable()
          ),
          const SizedBox(height: 10),
          Container(
            height: 50,
            margin: const EdgeInsets.only(bottom: 5.0),
            // alignment: Alignment.centerRight,
            decoration:const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    fixedSize: const Size(90, 8),
                  ),
                  child: Text(
                    FlutterI18n.translate(context, 'tr.ready_for_ship.delete'),
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  ),
                ),
                const SizedBox(width: 130),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () => context.go('/chatbox'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.tertiaryContainer),
                      fixedSize: MaterialStateProperty.all<Size>(const Size(100, 8))
                    ),
                    child: Text(
                      FlutterI18n.translate(context, 'tr.ready_for_ship.message'),
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}