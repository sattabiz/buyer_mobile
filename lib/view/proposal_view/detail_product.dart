import 'package:PaletPoint/view_model/proposal_controller/list_currencies_view_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/currency_model.dart';
import '../../view_model/proposal_controller/create_proposal_view_model.dart';

class ProposalBody extends ConsumerStatefulWidget {
  final int productId;
  final int index;
  final String paletteDimensions;
  final double itemCount;
  final double? price;

  const ProposalBody(
      {super.key,
      required this.productId,
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
    List<DropdownMenuItem<String>> dropDownMenuCurrency =
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
                top: BorderSide(width: 0.20), bottom: BorderSide(width: 0.20))),
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
                  TextFormField(
                    cursorColor: Theme.of(context).colorScheme.onBackground,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true, signed: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(
                          //r'^[-]{0,1}[0-9]*[,]?[0-9]*', //signed regex
                          r'^[0-9]*[,]?[0-9]*',
                        ),
                      ),
                    ],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.onPrimary,
                      contentPadding:
                          const EdgeInsets.only(left: 10.0, bottom: 10),
                      label: Text(
                        widget.price == null
                            ? "Fiyat"
                            : widget.price.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      constraints: const BoxConstraints(maxWidth: 150),
                      isDense: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                      border: const OutlineInputBorder(),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return FlutterI18n.translate(
                            context, 'tr.validations.price');
                      }
                      return null;
                    },
                    onChanged: (value) {
                      /* ref.read(formItemProvider.notifier).state[widget.index].price = double.parse(value);
                      ref.read(formItemProvider.notifier).state[widget.index].productId = widget.productId; */
                      if (boolean == false) {
                        ref
                            .read(formItemProvider.notifier)
                            .addFormItem(FormItem(), widget.productId);
                        boolean = true;
                      }
                      ref
                          .read(formItemProvider.notifier)
                          .addPrice(widget.productId, double.parse(value));
                    },
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
                      contentPadding:
                          const EdgeInsets.only(left: 5, bottom: 13, right: 5),
                      constraints: const BoxConstraints(
                        maxHeight: 35,
                        maxWidth: 80,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    items: dropDownMenuCurrency,
                    value: '₺', //ref.read(offerModelProvider).currencyCode,
                    onChanged: (value) {
                      if (boolean == false) {
                        ref
                            .read(formItemProvider.notifier)
                            .addFormItem(FormItem(), widget.productId);
                        boolean = true;
                      }
                      int selectedIndex = dropDownMenuCurrency
                          .indexWhere((item) => item.value == value);
                      ref
                          .read(formItemProvider.notifier)
                          .addCurrencies(widget.productId, selectedIndex);
                    },
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // IconButton(
                  //   padding: const EdgeInsets.only(bottom: 15),
                  //   onPressed: () async {
                  //     FilePickerResult? result = await FilePicker.platform.pickFiles();
                  //     if (result != null) {
                  //       PlatformFile file = result.files.first;
                  //       MultipartFile filetoMultipart = await MultipartFile.fromFile(
                  //         file.path!,
                  //         filename: file.name,
                  //       );
                  //       ref.read(formItemProvider.notifier).addImage(widget.productId, filetoMultipart);
                  //     } else {
                  //       return;
                  //     }
                  //   },
                  //   icon: Icon(
                  //     Icons.attach_file_outlined,
                  //     color: Theme.of(context).colorScheme.onSurfaceVariant,
                  //   )
                  // ),
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
                onChanged: (value) {
                  ref.read(formItemProvider.notifier)
                     .addNote(widget.productId, value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
