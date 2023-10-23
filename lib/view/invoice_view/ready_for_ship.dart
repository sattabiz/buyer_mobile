import 'package:buyer_mobile/view/invoice_view/ready_for_ship_card/ready_for_ship_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../view_model/get_shipment_view_model.dart';
import '../widget/app_bar/top_app_bar_centered.dart';



class ReadyForShipInvoice extends ConsumerWidget {
  ReadyForShipInvoice({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shipmentListAsyncValue = ref.watch(getShipmentProvider);
    return RefreshIndicator(
      onRefresh: () async{
        ref.refresh(getShipmentProvider);
      },
      child: shipmentListAsyncValue.when(
        data: (data) {
          return Stack(
            children: [
              Column(
                children: [
                  TopAppBarCentered(
                    title: FlutterI18n.translate(context, 'tr.ready_for_ship.title'),
                    backRoute: '/invoice',
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: data.length, //Bu products nereden geliyor
                      shrinkWrap: true,      //eleman sayisi kadar boyutun artsin
                      itemBuilder: (context, index) => ReadyForShipCard(shipmentList: data[index]),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(25.0),
                child: FloatingActionButton.extended(
                  label: Text(
                    FlutterI18n.translate(context, 'tr.ready_for_ship.generate_invoice'),
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                  icon: SvgPicture.asset(
                        'assets/Shape.svg',
                      ),
                  onPressed: () {
                    context.go('/invoice/invoice_ready/generate');
                  },
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          );
        },
        loading: () => Container(),
        error: (error, stack) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamed(context, '/login');
          });
          return Text('An error occurred: $error');
        },
      ),
    );
  }
}
