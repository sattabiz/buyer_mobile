import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TopAppBarCentered extends StatelessWidget implements PreferredSizeWidget {
    final String title;
    final String route;

  const TopAppBarCentered({ 
    Key? key,
    required this.title,
    required this.route,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context){
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.onSecondary,
          ),
        onPressed: () => context.go(route)
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
          color: Theme.of(context).colorScheme.onSecondary
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.menu,
            color: Theme.of(context).colorScheme.onSecondary,
            ),
          onPressed: () {
          },
        ),
      ],
    );
  }
}