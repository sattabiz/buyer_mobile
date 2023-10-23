import 'package:buyer_mobile/view/proposal_view/proposal_detail.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../view_model/proposal_controller/create_proposal_view_model.dart';
import '../../view_model/proposal_controller/get_proposal_view_model.dart';
import '../widget/detail_components/detail_info.dart';
import 'detail_product.dart';

class EditProposal extends ConsumerStatefulWidget {
  const EditProposal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditProposalState();
}

class _EditProposalState extends ConsumerState<EditProposal> {

  final TextEditingController _tgs = TextEditingController(text: "10");
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _tgs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final proposalAsyncValue = ref.watch(proposalIndexProvider);
    ref.read(offerModelProvider).proposalId = proposalAsyncValue!.proposalId;
    List<DropdownMenuItem<String>> dropDownMenuPaymentType =
        ["Cari Hesap", "DBS"].map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value.toString(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }).toList();

    List<DropdownMenuItem<String>> dropDownMenuDate =
        [3, 5, 7, 9, 11].map((int value) {
      return DropdownMenuItem<String>(
          value: value.toString(),
          child: Text(
            '$value İş günü',
            style: Theme.of(context).textTheme.bodyLarge,
          ));
    }).toList();
    return SingleChildScrollView(
      child: Container(
        color: Theme.of(context).colorScheme.onSecondary,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                FlutterI18n.translate(context, 'tr.proposal.proposal_detail'),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
            ),
            SizedBox(
              width: width,
              child: DetailInfo(
                  className: 'proposal',
                  row1: proposalAsyncValue.proposalCreatedAt
                      .toString()
                      .split('T')[0],
                  row2:
                      proposalAsyncValue.deliveryDate.toString().split('T')[0],
                  row3: proposalAsyncValue.paymentDueDate.toString(),
                  row4: proposalAsyncValue.includeShipmentCost == true
                      ? "Satıcı"
                      : "Alıcı"),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: width,
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField2<String>(
                      decoration: InputDecoration(
                        labelText: FlutterI18n.translate(
                            context, 'tr.proposal.proposal_period'),
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        floatingLabelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        contentPadding: const EdgeInsets.only(
                            left: 5, bottom: 13, right: 5),
                        constraints: const BoxConstraints(
                          maxHeight: 40,
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
                      items: dropDownMenuDate,
                      value:
                          ref.read(offerModelProvider).deliveryTime.toString(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select gender.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        String time = value!.split(" ")[0];
                        ref.read(offerModelProvider).deliveryTime =
                            int.parse(time);
                        //debugPrint(value!.split(" ")[0]);
                      },
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _tgs,
                      cursorColor: Theme.of(context).colorScheme.onBackground,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.onPrimary,
                        contentPadding: const EdgeInsets.only(left: 10.0),
                        label: Text(
                          'Teklif Gecerlilik Suresi',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        constraints: const BoxConstraints(maxHeight: 40),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        ref.read(offerModelProvider).validPeriod =
                            int.parse(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: width,
              alignment: Alignment.centerLeft,
              child: DropdownButtonFormField2<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: FlutterI18n.translate(
                      context, 'tr.proposal.payment_type'),
                  labelStyle: Theme.of(context).textTheme.bodySmall,
                  floatingLabelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  contentPadding:
                      const EdgeInsets.only(left: 5, bottom: 13, right: 5),
                  constraints: const BoxConstraints(
                    maxHeight: 40,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                items: dropDownMenuPaymentType,
                validator: (value) {
                  if (value == null) {
                    return 'Please select gender.';
                  }
                  return null;
                },
                onChanged: (value) {
                  // ref.read(offerModelProvider).paymentType = value;
                },
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                FlutterI18n.translate(context, 'tr.proposal.products'),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: proposalAsyncValue.productProposals!.length,
              itemBuilder: (context, index) {
                return ProposalBody(
                  index: index,
                  productId: proposalAsyncValue
                      .productProposals![index].productProposalId!,
                  paletteDimensions:
                      proposalAsyncValue.productProposals![index].name!,
                  itemCount:
                      proposalAsyncValue.productProposals![index].amount!,
                  price: proposalAsyncValue.productProposals![index].price,
                );
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: ElevatedButton(
                onPressed: () {
                  if (proposalAsyncValue.updateCounter == 3) {
                  } else {
                    ref.watch(createProposalProvider);
                    context.go('/proposal');
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.primary),
                  fixedSize:
                      MaterialStateProperty.all<Size>(const Size(180, 30)),
                ),
                child: Text(
                  'Teklif Gönder (${ref.watch(proposalIndexProvider)!.updateCounter.toString()}/3)',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
