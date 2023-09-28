import 'package:buyer_mobile/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ListTile(
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
              ),
              SizedBox(
                width: 100,
                child: Text(
                  subtitle2 ?? ' ',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                subtitle3 ?? ' ',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
              Text(
                subtitle4 ?? ' ',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ],
          ),
          trailing: trailing,
          onTap: () {
            onTap!();
          },
        ),
        const Divider(
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }
}
