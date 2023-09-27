import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../view_model/get_proposal_view_model.dart';
import '../../view_model/login_view_model.dart';
import '../widget/index_list_tile.dart';
import 'counter.dart';
import 'proposal_detail.dart';

class ProposalView extends ConsumerStatefulWidget {
  const ProposalView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProposalState();
}

class _ProposalState extends ConsumerState<ProposalView> {
  @override
  Widget build(BuildContext context) {
    final proposalListAsyncValue = ref.watch(getProposalProvider);
    return proposalListAsyncValue.when(
      data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) => IndexListTile(
            title: "Teklif No: ${data[index].proposalId.toString()}",
            subtitle: 'Subtitle',
            svgPath: 'assets/alert.svg',
            // trailing: const Counter(),
            //onTap: () => context.go('/proposal/detail'),
            onTap: () async {
              ref.read(proposalIndexProvider.notifier).state = data[index];   
              context.go('/proposal/detail');
            },
          ),
        );
      },
      loading: () => Container(),
      error: (error, stack) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, '/login');
        });
        return Text('An error occurred: $error');
      },
    );

    /* ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) => IndexListTile(
        title: 'Headline',
        subtitle: 'Subtitle',
        svgPath: 'assets/alert.svg',
        // trailing: const Counter(),
        //onTap: () => context.go('/proposal/detail'),
        onTap: () async {
          ref.watch(getProposalProvider);
          context.go('/proposal/detail');
        },
      ),
    ); */
  }
}
