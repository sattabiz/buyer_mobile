import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    Key? key,
    required this.currentIndex, 
    required this.onItemTapped,
   }) : super(key: key);

  final int currentIndex;
  final void Function(int index) onItemTapped;

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: widget.currentIndex,
      animationDuration: const Duration(milliseconds: 300),
      onDestinationSelected: widget.onItemTapped,
      backgroundColor: Theme.of(context).colorScheme.surface,
      destinations: [
        NavigationDestination(
          icon: SvgPicture.asset(
            'assets/svg/home2.svg',
          ),
          label: FlutterI18n.translate(context, 'tr.bottom_navigation_bar.home'),
        ),
        NavigationDestination(
          icon: SvgPicture.asset(
            'assets/svg/proposal_index.svg',
          ),
          label: FlutterI18n.translate(context, 'tr.bottom_navigation_bar.proposal'),
        ),
        NavigationDestination(
          icon: SvgPicture.asset(
            'assets/svg/order_navigation.svg',
          ),
          label: FlutterI18n.translate(context, 'tr.bottom_navigation_bar.order'),
        ),
        NavigationDestination(
          icon: SvgPicture.asset(
            'assets/svg/invoice_bottom.svg',
          ),
          label: FlutterI18n.translate(context, 'tr.bottom_navigation_bar.invoice'),
        ),

      ],
      
    );
  }
}