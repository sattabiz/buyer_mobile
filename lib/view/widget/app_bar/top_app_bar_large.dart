import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';


class TopAppBarLarge extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBarLarge({ 
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context){
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
            // IconButton(
            //   icon: const Icon(
            //     Icons.menu,
            //     color: Colors.white,
            //     ),
            //   onPressed: () {} //context.go('/login')
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SvgPicture.asset(
                'assets/svg/home_page_logo.svg',
              )
            ),
          ],
        ),
      ),
    );
  }
}