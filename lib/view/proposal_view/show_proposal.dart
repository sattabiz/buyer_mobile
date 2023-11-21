import 'package:PaletPoint/utils/widget_helper.dart';
import 'package:PaletPoint/view/proposal_view/proposal_detail.dart';
import 'package:PaletPoint/view/proposal_view/show_proposal_info.dart';
import 'package:PaletPoint/view/widget/detail_components/detail_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../view_model/proposal_controller/get_proposal_view_model.dart';
import '../widget/detail_components/detail_table_panel.dart';

class ShowProposal extends ConsumerWidget {
  const ShowProposal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final proposalAsyncValue = ref.watch(proposalIndexProvider);
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
              child: ShowProposalInfo(
                row1: formattedDate( proposalAsyncValue!.proposalCreatedAt.toString()),
                row2: ref.read(offerModelProvider).deliveryTime.toString(),
                row3: proposalAsyncValue.paymentDueDate.toString(), 
                row4: proposalAsyncValue.includeShipmentCost == true
                      ? "Satıcı"
                      : "Alıcı",
                row5: proposalAsyncValue.paymentType.toString(),
                row6: Text(
                        "${proposalAsyncValue.proposalValidPeriod.toString()} gün",
                        style: Theme.of(context).textTheme.bodyMedium
                      )
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: width,
              padding: const EdgeInsets.all(5.0),
              child: DetailTable(
                products: proposalAsyncValue.productProposals!,
              ),
            ),
            SizedBox(
              width: width,
              height: 100,
              child: DetailTablePanel(
                productList: proposalAsyncValue.productProposals!,
                isFileAttached: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
