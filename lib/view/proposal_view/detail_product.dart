import 'package:buyer_mobile/view_model/proposal_controller/list_currencies_view_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../view_model/proposal_controller/create_proposal_view_model.dart';



class ProposalBody extends ConsumerStatefulWidget {
  final int productId;
  final int index;
  final String paletteDimensions;
  final double itemCount;
  final double? price;
  ProposalBody(
      {required this.productId,
      required this.index,
      required this.paletteDimensions,
      required this.itemCount,
      this.price});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProposalBodyState();
}

class _ProposalBodyState extends ConsumerState<ProposalBody> {
  bool isTextFieldVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    List<CurrencyModel> currencyAsyncValues = ref.watch(currenciesProvider);
    List<DropdownMenuItem<String>> dropDownMenuCurrency=
        currencyAsyncValues.map((currencyAsyncValues) {
      return DropdownMenuItem<String>(
        value: currencyAsyncValues.symbol,
        child: Text(
          currencyAsyncValues.symbol.toString(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }).toList();
    bool boolean = false;
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 0.20), 
            bottom: BorderSide(width: 0.20)
          )
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.all(0.0),
          iconColor: Theme.of(context).colorScheme.onBackground,
          controlAffinity: ListTileControlAffinity.trailing,
          title: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.paletteDimensions,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '${widget.itemCount} adet',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              )
            ],
          ),
          subtitle: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: TextFormField(
                      cursorColor: Theme.of(context).colorScheme.onBackground,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.onPrimary,
                        contentPadding: const EdgeInsets.only(left: 10.0),
                        label: Text(
                          widget.price == null ? "Fiyat" : widget.price.toString() ,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        constraints: const BoxConstraints(maxHeight: 35, maxWidth: 150),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Theme.of(context).colorScheme.onSurfaceVariant),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Lütfen fiyat giriniz.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        /* ref.read(formItemProvider.notifier).state[widget.index].price = double.parse(value);
                        ref.read(formItemProvider.notifier).state[widget.index].productId = widget.productId; */
                        if(boolean == false){
                          ref.read(formItemProvider.notifier).addFormItem(FormItem(), widget.productId);
                          boolean = true;
                        }
                        ref.read(formItemProvider.notifier).addPrice(widget.productId, double.parse(value));
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownButtonFormField2<String>(  
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelStyle: Theme.of(context).textTheme.bodySmall,
                      floatingLabelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      contentPadding: const EdgeInsets.only(
                          left: 5, bottom: 13, right: 5),
                      constraints: const BoxConstraints(
                        maxHeight: 35,
                        maxWidth: 80,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    items: dropDownMenuCurrency,
                    value: '₺', //ref.read(offerModelProvider).currencyCode,
                    validator: (value) {
                      if (value == null) {
                        return 'Please select gender.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      if(boolean == false ){
                          ref.read(formItemProvider.notifier).addFormItem(FormItem(), widget.productId);
                          boolean = true;
                        }
                        int selectedIndex = dropDownMenuCurrency.indexWhere((item) => item.value == value);
                        ref.read(formItemProvider.notifier).addCurrencies(widget.productId, selectedIndex);     
                    },
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              )
            ],
          ),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 40.0, bottom: 10.0),
              child: TextFormField(
                cursorColor: Theme.of(context).colorScheme.onBackground,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.onPrimary,
                  contentPadding: const EdgeInsets.only(left: 10.0),
                  label: Text(
                    'Not',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  constraints: const BoxConstraints(maxHeight: 35),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen konu giriniz.';
                  }
                  return null;
                },
                onChanged: (value) {
                  ref.read(formItemProvider.notifier).addNote(widget.productId, value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
