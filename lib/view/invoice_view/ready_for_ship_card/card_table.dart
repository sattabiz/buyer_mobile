import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../model/shipment_model.dart';
import '../../../view_model/generate_multi_order_controller/multi_order_invoice_view_model.dart';

class CardTable extends ConsumerStatefulWidget {
  List<Product> shipmentProduct;
  CardTable({super.key, required this.shipmentProduct});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CardTableState();
}

class _CardTableState extends ConsumerState<CardTable> {
  bool _isAllSelected = false;

  @override
  Widget build(BuildContext context) {
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
                  onChanged: (value) async{
                    //ref.watch(multiOrderProvider.notifier).checkBox(, checkbox)
                    _isAllSelected=!_isAllSelected;
                    setState(() {

                    });
                    for(int i = 0; i<widget.shipmentProduct.length;i++){
                      if(value == true) {
                        ref.read(multiOrderProvider.notifier).addFormItem(widget.shipmentProduct[i]);
                        widget.shipmentProduct[i].checkbox = value;
                      } else {
                        ref.read(multiOrderProvider.notifier).removeFormItem(widget.shipmentProduct[i].productsProposalShipmentId!);
                        widget.shipmentProduct[i].checkbox = value;
                      }
                    }
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
        for (var i = 0; i < widget.shipmentProduct.length; i++)
          TableRow(
            children: [
              Container(
                width: 20,
                height: 30,
                margin: const EdgeInsets.only(bottom: 5.0),
                alignment: Alignment.center,
                child: Checkbox(
                    value: widget.shipmentProduct[i].checkbox,
                    onChanged: (value) async{
                      setState((){
                        widget.shipmentProduct[i].checkbox = value;
                        widget.shipmentProduct[i].copyWith(checkbox: value);
                      });
                      if(value == true) {
                        ref.read(multiOrderProvider.notifier).addFormItem(widget.shipmentProduct[i]);
                      } else {
                        ref.read(multiOrderProvider.notifier).removeFormItem(widget.shipmentProduct[i].productsProposalShipmentId!);
                      }
                    }
                    ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8.0),
                alignment: Alignment.centerLeft,
                child: Text(widget.shipmentProduct[i].name!,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        )),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8.0),
                alignment: Alignment.center,
                child: Text(widget.shipmentProduct[i].shippedAmount!.toString(),    //amount gelmiyor simdilik shippedAmount duruyor
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        )),
              ),
              Container(
                margin: const EdgeInsets.all(5.0),
                alignment: Alignment.center,
                child: TextFormField(
                  initialValue: widget.shipmentProduct[i].invoiceAmount!.toString(),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
                  decoration: InputDecoration(
                    constraints: const BoxConstraints(maxHeight: 25),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),

                  ),
                  onChanged: (value) {
                    if(value != ''){
                      ref.read(multiOrderProvider.notifier).readShippedAmount(widget.shipmentProduct[i].productsProposalShipmentId!, double.parse(value));
                      widget.shipmentProduct[i].invoiceAmount = double.parse(value);
                    }
                  },
                ),
              ),
            ],
          ),
      ],
    );
  }
}
