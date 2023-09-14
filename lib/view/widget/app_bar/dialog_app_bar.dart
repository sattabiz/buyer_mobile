import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DialogAppBar extends StatelessWidget {
  final String title;
  final String route;

  const DialogAppBar({
    Key? key,
    required this.title,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          onPressed: () => context.go(route)
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(
            'Kaydet',
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
      ],
    );
  }
}
