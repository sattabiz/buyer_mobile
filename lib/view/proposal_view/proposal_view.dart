import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) => IndexListTile(
        title: 'Headline',
        subtitle: 'Subtitle',
        svgPath: 'assets/alert.svg',
        // trailing: const Counter(),
        onTap: () => context.go('/proposal/detail'),
      ),
    );
  }
}
