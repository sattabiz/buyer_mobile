import 'package:flutter/material.dart';
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
      onDestinationSelected: widget.onItemTapped,
      backgroundColor: Theme.of(context).colorScheme.surface,
      destinations: [
        NavigationDestination(
          icon: SvgPicture.asset(
            'assets/home.svg',
          ),
          label: 'Ana Sayfa',
        ),
        NavigationDestination(
          icon: SvgPicture.asset(
            'assets/proposal.svg',
          ),
          label: 'Teklif',
        ),
        NavigationDestination(
          icon: SvgPicture.asset(
            'assets/order.svg',
          ),
          label: 'Siparis',
        ),
        NavigationDestination(
          icon: SvgPicture.asset(
            'assets/invoice.svg',
          ),
          label: 'Fatura',
        ),

      ],
      
    );
  }
}