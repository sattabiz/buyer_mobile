import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../view_model/logout_view_model.dart';

class CustomAppBar extends PreferredSize {
  @override
  final Widget child;
  final double height;

  CustomAppBar({
    super.key, 
    required this.height,
    required this.child,
  }) : super(child: child, preferredSize: Size.fromHeight(AppBar().preferredSize.height));
}

class TopAppBarLarge extends ConsumerWidget implements PreferredSizeWidget {
  const TopAppBarLarge({ 
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return AppBar(
      toolbarHeight: 110,
      leadingWidth: 300,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SvgPicture.asset(
                'assets/svg/home_page_logo.svg',
              )
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => context.go('/profile'), 
          icon: SvgPicture.asset(
            'assets/svg/profile.svg',
          ),
        ),
        SubmenuButton(
          menuChildren: [
            MenuItemButton(
              onPressed: () async {
                final logoutViewModel =ref.read(logoutViewModelProvider.notifier);
                await logoutViewModel.logout();
                context.go('/login');
              },
              child: const MenuAcceleratorLabel('&Çıkış'),
            ),
          ], 
          child:const Icon(
            Icons.menu,
              color: Colors.white,
          ),
        )
      ],
    );
  }
}