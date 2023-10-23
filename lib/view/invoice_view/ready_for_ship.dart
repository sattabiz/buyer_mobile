import 'package:PaletPoint/view/invoice_view/ready_for_ship_card/ready_for_ship_card.dart';
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
                mainAxisSize: MainAxisSize.max,
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
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/invoice/invoice_ready/generate');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                    fixedSize: MaterialStateProperty.all<Size>(
                      const Size(180.0, 60.0),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        'assets/Shape.svg',
                        width: 40,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        FlutterI18n.translate(context, 'tr.ready_for_ship.generate_invoice'),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
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
