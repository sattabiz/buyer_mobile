import 'package:buyer_mobile/view/widget/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'home.dart';
import 'proposal_view/proposal_view.dart';
import 'widget/app_bar/top_app_bar_large.dart';


class Index extends ConsumerWidget {
  PreferredSizeWidget customAppBar;

   Index(
    this.navigationShell,
    this.customAppBar,
    {Key? key
  }) : super(key: key);

  String title = 'Palet Point';

  // void changeTitle(int index) {
  //   switch(index) { 
  //     case 0: { title = 'Palet Point'; } 
  //     break; 
  //     case 1: { title = 'Teklif İstekleri'; } 
  //     break;
  //     case 2: { title = 'SİPARİŞLER'; } 
  //     break;
  //     case 3: { title = 'FATURALAR'; } 
  //     break;
  //   } 
  // }

  void _onTap(index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
  
 final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: customAppBar,
      body: navigationShell,
      bottomNavigationBar: BottomNavigation(
        currentIndex: navigationShell.currentIndex,
        onItemTapped: _onTap,
      ),
    );
  }
}
