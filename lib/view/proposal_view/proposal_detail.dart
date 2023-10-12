import 'package:buyer_mobile/view_model/proposal_controller/get_proposal_view_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../view_model/message_controller/get_message_view_model.dart';
import '../../view_model/proposal_controller/create_proposal_view_model.dart';
import '../widget/app_bar/top_app_bar_left.dart';
import '../widget/detail_components/detail_info.dart';
import 'detail_product.dart';

class OfferModel {
  int? proposalId;
  int deliveryTime;
  int validPeriod;

  OfferModel(
      {this.proposalId, required this.deliveryTime, required this.validPeriod});
}

final offerModelProvider = Provider((ref) => OfferModel(
      deliveryTime: 3,
      validPeriod: 10,
    ));

class ProposalDetail extends ConsumerStatefulWidget {
  final String proposalId;
  const ProposalDetail({
    required this.proposalId,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProposalDetailState();
}

class _ProposalDetailState extends ConsumerState<ProposalDetail> {
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
    final proposalAsyncValue = ref.watch(proposalIndexProvider);
    final chatProvider = ref.watch(getMessageProvider);
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
            value.toString(),
            style: Theme.of(context).textTheme.bodyLarge,
          ));
    }).toList();

    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          TopAppBarLeft(
            title: 'Teklif No: ${proposalAsyncValue.proposalId}',
            icon: Icons.chat_bubble_outline,
            backRoute: () => context.go('/proposal'),
            chatRoute: () => context.goNamed('proposal_chat', pathParameters: {
              'proposalId': proposalAsyncValue.proposalId.toString(),
              'chatId': '1' //bakilcak
            }),
          ),
          SingleChildScrollView(
            child: Container(
              color: Theme.of(context).colorScheme.onSecondary,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      FlutterI18n.translate(
                          context, 'tr.proposal.proposal_detail'),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
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
                        row2: proposalAsyncValue.deliveryDate
                            .toString()
                            .split('T')[0],
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
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
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
                            value: ref
                                .read(offerModelProvider)
                                .deliveryTime
                                .toString(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select gender.';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              ref.read(offerModelProvider).deliveryTime =
                                  value as int;
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
                            cursorColor:
                                Theme.of(context).colorScheme.onBackground,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  Theme.of(context).colorScheme.onPrimary,
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
                              debugPrint(value);
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
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
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
                        paletteDimensions: proposalAsyncValue
                            .productProposals![index].productName!,
                        itemCount:
                            proposalAsyncValue.productProposals![index].amount!,
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
                        fixedSize: MaterialStateProperty.all<Size>(
                            const Size(180, 30)),
                      ),
                      child: Text(
                        'Teklif Gönder (${ref.watch(proposalIndexProvider)!.updateCounter.toString()}/3)',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
