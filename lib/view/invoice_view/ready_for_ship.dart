import 'package:buyer_mobile/view/invoice_view/ready_for_ship_card/ready_for_ship_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../utils/widget_helper.dart';
import '../widget/app_bar/top_app_bar_centered.dart';

class ReadyForShipInvoice extends StatelessWidget {
   ReadyForShipInvoice({ Key? key }) : super(key: key);

ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: TopAppBarCentered(
          title: FlutterI18n.translate(context, 'tr.ready_for_ship.title'),
          route: '/invoice',
        ),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: products.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => ReadyForShipCard(),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () => context.go('/invoice_ready/generate'),
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
        child:  Row(
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
    );
  }
}