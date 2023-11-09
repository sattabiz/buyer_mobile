import 'package:PaletPoint/model/shipment_model.dart';
import 'package:PaletPoint/view_model/shipment_cancel_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../view_model/message_controller/create_message_view_model.dart';
import '../../../view_model/message_controller/get_message_view_model.dart';
import '../../../view_model/message_controller/websocket_message_view_model.dart';
import '../../proposal_view/proposal_view.dart';
import 'card_table.dart';

class ReadyForShipCard extends ConsumerStatefulWidget {
  final ShipmentModel shipmentList;
  final bool message;
  const ReadyForShipCard({
    Key? key, 
    required this.shipmentList, 
    required this.message
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReadyForShipCardState();
}

class _ReadyForShipCardState extends ConsumerState<ReadyForShipCard> {
  @override
  Widget build(BuildContext context) {
    final chatId = ref.watch(messageRoomIdProvider);
    debugPrint(widget.message.toString());
    return Card(
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      elevation: 4,
      margin: const EdgeInsets.only(
          bottom: 20.0, right: 20.0, left: 20.0, top: 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 65,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.35),
            ),
            child: ListTile(
              title: Row(
                children: [
                  Text(
                    FlutterI18n.translate(context, 'tr.ready_for_ship.order_no'),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  Text(
                    widget.shipmentList.shipmentId.toString(), //order id eklenecek
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
              subtitle: Row(
                children: [
                  Text(
                    FlutterI18n.translate(context, 'tr.ready_for_ship.tracking'),
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  Text(
                    widget.shipmentList.includeShipmentCost!
                        ? "Alıcı"
                        : "Satıcı",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    FlutterI18n.translate(context, 'tr.ready_for_ship.payment'),
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  Text(
                    widget.shipmentList.paymentType ?? 'Api data Null',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: SvgPicture.asset(
                  widget.message
                    ? 'assets/svg/chat_unread_red.svg'
                    : 'assets/svg/chat_black.svg',
                ),
                onPressed: () {
                  ref.read(messageIdProvider.notifier).state =
                      'shipment_id=${widget.shipmentList.shipmentId}';
                  ref.read(createMessageMapProvider.notifier).state = {
                    'shipment_id': widget.shipmentList.shipmentId
                  };
                  ref.read(chatBoxHeaderProvider.notifier).state =
                      "Sevkiyat No: ${widget.shipmentList.shipmentId}";
                  ref.watch(getMessageProvider);
                  ref.read(messagePipeProvider.notifier).state = 1;
                  ref.watch(webSocketProvider);
                  context.goNamed('invoice_ready_chat',
                      pathParameters: {'chatId': '$chatId'});
                },
              ),              
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            child: CardTable(
              shipmentProduct: widget.shipmentList.products!,
          )),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 5.0),
            child: OutlinedButton(
              onPressed: () async {
                ref.read(cancelShipmentIdProvider.notifier).state =
                    widget.shipmentList.shipmentId.toString();
                ref.watch(cancelPreparedShipmentController);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                ),
                fixedSize: const Size(90, 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text(
                FlutterI18n.translate(context, 'tr.ready_for_ship.delete'),
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
