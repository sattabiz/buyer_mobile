
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../view_model/proposal_controller/create_proposal_view_model.dart';



class ProposalBody extends ConsumerStatefulWidget {
  final int productId;
  final int index;
  final String paletteDimensions;
  final double itemCount;

  ProposalBody(
      {required this.productId,
      required this.index,
      required this.paletteDimensions,
      required this.itemCount});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProposalBodyState();
}

class _ProposalBodyState extends ConsumerState<ProposalBody> {
  bool isTextFieldVisible = false;

  String? dropdownValue;

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
    int productId = 0;
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 0.15), 
            bottom: BorderSide(width: 0.15)
          )
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.all(0.0),
          iconColor: Theme.of(context).colorScheme.onBackground,
          controlAffinity: ListTileControlAffinity.trailing,
          title: Column(
            children: [
              const SizedBox(
                height: 15,
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
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      cursorColor: Theme.of(context).colorScheme.onBackground,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.onPrimary,
                        contentPadding: const EdgeInsets.only(left: 10.0),
                        label: Text(
                          'Fiyat',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        constraints: const BoxConstraints(maxHeight: 35),
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
                        if(productId != widget.productId ){
                          ref.read(formItemProvider.notifier).addFormItem(FormItem(), widget.productId);
                          productId = widget.productId;
                        }
                        ref.read(formItemProvider.notifier).addPrice(widget.productId, double.parse(value));
    
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      cursorColor: Theme.of(context).colorScheme.onBackground,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.onPrimary,
                        contentPadding: const EdgeInsets.only(left: 10.0),
                        label: Text(
                          'tl  ',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        constraints: const BoxConstraints(maxHeight: 35),
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
