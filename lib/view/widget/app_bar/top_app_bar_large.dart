import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

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

class TopAppBarLarge extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const TopAppBarLarge({ 
    Key? key,
    required this.title,
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            // IconButton(
            //   icon: const Icon(
            //     Icons.menu,
            //     color: Colors.white,
            //     ),
            //   onPressed: () {} //context.go('/login')
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: 
              title == 'Palet Point'
              ? SvgPicture.asset(
                'assets/svg/home_page_logo.svg',
                // width: 200,
                // height: 50,
              )
              :Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary
                ), 
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}