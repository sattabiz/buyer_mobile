import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/routes.dart';

class TopAppBarCentered extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String ?backRoute;

  const TopAppBarCentered({
    Key? key,
    required this.title,
     this.backRoute,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // debugPrint("${state.pa}");
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        onPressed: () => backRoute == "null" ? context.pop() : context.go(backRoute!) 
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: Theme.of(context).colorScheme.onSecondary),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.menu,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
