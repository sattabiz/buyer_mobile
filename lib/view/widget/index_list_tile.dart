
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class IndexListTile extends ConsumerWidget {
  final String title;
  final String subtitle;
  final String ?subtitle2;
  final String ?subtitle3;
  final String ?subtitle4;
  final String svgPath;
  final Widget? trailing;
  final double ?width;
  final Function()? onTap;

  const IndexListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    this.subtitle2,
    this.subtitle3,
    this.subtitle4,
    required this.svgPath,
    this.trailing,
    this.onTap,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            width: 0.3,
          ),
        ),
      ),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 5.0),
          child: SvgPicture.asset(
            svgPath,
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        subtitle: Row(
          children: [
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
              maxLines: 1,
            ),
            Text(
              subtitle2 ?? ' ',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: 5.0),
            Text(
              subtitle3 ?? ' ',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            Flexible(
              child: Text(
                subtitle4 ?? ' ',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        trailing: trailing,
        onTap: () {
          onTap!();
        },
      ),
    );
  }
}
