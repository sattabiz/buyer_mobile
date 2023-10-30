import 'package:PaletPoint/utils/widget_helper.dart';
import 'package:PaletPoint/view_model/get_notifications_view_model.dart';
import 'package:PaletPoint/view_model/get_order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:swipe/swipe.dart';
import '../../view_model/message_controller/create_message_view_model.dart';
import '../../view_model/proposal_controller/create_proposal_view_model.dart';
import '../../view_model/proposal_controller/get_proposal_view_model.dart';
import '../../view_model/proposal_controller/list_currencies_view_model.dart';
import '../widget/app_bar/top_app_bar_left.dart';
import '../widget/index_list_tile.dart';
final messageIdProvider = StateProvider<String?>((ref) => '');

class ProposalView extends ConsumerStatefulWidget {
  const ProposalView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProposalState();
}

class _ProposalState extends ConsumerState<ProposalView> {
  @override
  Widget build(BuildContext context) {
    final proposalListAsyncValue = ref.watch(getProposalProvider);
    ref.watch(getListCurrenciesProvider);
    return Swipe(
      onSwipeLeft: () async{
        ref.refresh(getOrderProvider);
        context.go('/order');
      },
      onSwipeRight:() async{
        ref.refresh(getNotificationProvider);
        context.go('/home');
      },
      child: RefreshIndicator(
        onRefresh: () async{
          await ref.refresh(getProposalProvider);        
        },
        child: proposalListAsyncValue.when(
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => IndexListTile(
                title: "Teklif No: ${data[index].proposalId.toString()}",
                subtitle: data[index].demandListName!, //proposalName gelecek
                svgPath: statusIconMap[data[index].proposalState] ?? '',
                trailing: (() {                                                                               //for widget notification icons
                  if (data[index].messageNotification == true) {
                    return SvgPicture.asset(                  
                      "assets/svg/chat.svg"
                    );
                  } else {
                    return SizedBox();
                  }
                })(),
                onTap: () async {
                  ref.read(messageIdProvider.notifier).state = 'proposal_id=${data[index].proposalId}';
                  ref.read(createMessageMapProvider.notifier).state = {'proposal_id': data[index].proposalId};
                  ref.read(chatBoxHeaderProvider.notifier).state = "Teklif No: ${data[index].proposalId}";
                  ref.read(proposalIndexProvider.notifier).state = data[index];
                  ref.watch(getListCurrenciesProvider);
                  ref.refresh(formItemProvider);
                  ref.read(messageIconProvider.notifier).state = data[index].messageNotification;
                  context.goNamed('proposal_detail', pathParameters: {'proposalId' : data[index].proposalId.toString()});
                },
              ),
            );
          },
          loading: () => Container(),
          error: (error, stack) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/login');  
            });
            return Text('An error occurred: $error');
          },
        ),
      ),
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
