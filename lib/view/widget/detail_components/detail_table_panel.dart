import 'package:flutter/material.dart';

import '../../../utils/widget_helper.dart';

class DetailTablePanel extends StatelessWidget {
  final List<dynamic> productList;
  final bool isFileAttached;
  final bool isPending;

  const DetailTablePanel({
    Key? key,
    required this.productList,
    required this.isFileAttached,
    required this.isPending,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> keys = getTotalCost
        .entries
        .map((entry) => Container(
              margin: const EdgeInsets.only(top: 5.0),
              alignment: Alignment.centerRight,
              width: 100,
              child: Text(
                entry.key,
                style: Theme.of(context).textTheme.labelMedium,
                maxLines: 1,
              ),
            ))
        .toList();

    List<Widget> values = getTotalCost
        .entries
        .map((entry) => Container(
              margin: const EdgeInsets.only(top: 5.0),
              alignment: Alignment.centerRight,
              width: 50,
              child: Text(
                isPending ? "-" : entry.value,
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w400),
              ),
            ))
        .toList();

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 5.0, right: 10.0, bottom: 10.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(child: Column(children: keys)),
              Flexible(child: Column(children: values)),
              isFileAttached == true
                  ? const SizedBox(width: 10)
                  : const SizedBox(width: 0),
            ]),
      ),
    );
  }
}
