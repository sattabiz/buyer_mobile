import 'package:PaletPoint/view/proposal_view/edit_proposal.dart';
import 'package:PaletPoint/view/proposal_view/show_proposal.dart';
import 'package:PaletPoint/view_model/proposal_controller/get_proposal_view_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swipe/swipe.dart';
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
    final proposalAsyncValue = ref.watch(proposalIndexProvider);  
    final chatId = ref.watch(messageRoomIdProvider);
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

    double width = MediaQuery.of(context).size.width;
    debugPrint(proposalAsyncValue.productProposals.toString());
    return Swipe(
      onSwipeRight: () {
        context.go('/proposal');
      },
      onSwipeLeft: () => context.goNamed('proposal_chat', pathParameters: {
        'proposalId': proposalAsyncValue.proposalId.toString(),
        'chatId': '$chatId'
      }),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TopAppBarLeft(
              title: 'Teklif No: ${proposalAsyncValue.proposalId}',
              backRoute: () => context.go('/proposal'),
              chatRoute: () => context.goNamed('proposal_chat', pathParameters: {
                'proposalId': proposalAsyncValue.proposalId.toString(),
                'chatId': '$chatId'
              }),
              refreshProvider: () async{
                ref.refresh(getProposalProvider);   
                ref.refresh(getProposalProvider.future);
              },
            ),
            proposalAsyncValue.proposalState == 'last_offer' || proposalAsyncValue.proposalState == 'proposal_stvs'
            ? const ShowProposal()
            : const EditProposal(),
          ],
        ),
      ),
    );
  }
}
