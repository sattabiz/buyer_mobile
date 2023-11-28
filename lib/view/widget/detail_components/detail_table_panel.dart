import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/widget_helper.dart';
import '../../../view_model/get_invoice_view_model.dart';

class DetailTablePanel extends ConsumerWidget {
  final List<dynamic> productList;
  final bool isFileAttached;
  final String? price;
  final String? priceWithoutVat;
  final String pageName;

  const DetailTablePanel(
      {Key? key,
      required this.productList,
      required this.isFileAttached,
      this.price,
      this.priceWithoutVat,
      required this.pageName})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> keys = calculateTaxRate(productList)
        .entries
        .map((entry) => Container(
              margin: const EdgeInsets.only(top: 5.0),
              alignment: Alignment.centerRight,
              width: 150,
              child: Text(
                entry.key,
                style: Theme.of(context).textTheme.labelMedium,
                maxLines: 1,
              ),
            ))
        .toList();
    Widget buildPrice(String? value){
      return Container(
        margin: const EdgeInsets.only(top: 5.0),
        alignment: Alignment.centerRight,
         // width: 50,
        child: Text(
          value!,
          maxLines: 1,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
          ),
        );
    }
    Widget buildWidget() {
      if (pageName == "invoice") {
        String? currenciesValue = ref.watch(invoiceCurrenciesIndexProvider);
        return Text(
          currenciesValue!,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(fontWeight: FontWeight.w400),
        );
      } else {
        return Container();
      }
    }
    double splitString(price){                             //Split prive and price_without_vat for KDV
      List<String>? value= price?.split(" ");
      double parsedPrice = double.parse((value![0]).replaceAll(",", "."));
      
      return parsedPrice;
    }

    String kdv = (splitString(price)-splitString(priceWithoutVat)).toStringAsFixed(2);    //KDV value
    return Container(
      margin: const EdgeInsets.only(top: 5.0, right: 10.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Spacer(flex: 1),
                Flexible(child: Column(children: keys)),
                Flexible(child: Column(children: [buildPrice(priceWithoutVat), buildPrice("$kdv ₺"), buildPrice(price)],)),
                isFileAttached == true
                    ? const SizedBox(width: 10)
                    : const SizedBox(width: 0),
              ]),
          const SizedBox(
            height: 10,
          ),
          buildWidget()
        ],
      ),
    );
  }
}
