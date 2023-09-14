import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IndexListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String svgPath;
  final Widget? trailing;
  final void Function() ?onTap;


  const IndexListTile({ 
    Key? key,
    required this.title,
    required this.subtitle,
    required this.svgPath,
    this.trailing, 
    this.onTap,

  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        ListTile(
          leading: SvgPicture.asset(
            svgPath,
            width: 20,
            height: 24,
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant
            ),
          ),
          subtitle: Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant
            ),
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