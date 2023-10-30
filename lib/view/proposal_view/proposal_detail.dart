import 'package:PaletPoint/view/proposal_view/edit_proposal.dart';
import 'package:PaletPoint/view/proposal_view/show_proposal.dart';
import 'package:PaletPoint/view_model/proposal_controller/get_proposal_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../view_model/message_controller/get_message_view_model.dart';
import '../widget/app_bar/top_app_bar_left.dart';


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
    
    return SingleChildScrollView(
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
    );
  }
}
