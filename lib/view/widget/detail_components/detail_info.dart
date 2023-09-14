import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class DetailInfo extends StatelessWidget {
  final String className;
  final String row1;
  final String row2;
  final String row3;
  final String row4;

   const DetailInfo({
    Key? key,
    required this.className,
    required this.row1,
    required this.row2,
    required this.row3,
    required this.row4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(0.2),
        1: FlexColumnWidth(0.2),
        2: FlexColumnWidth(0.1),
        3: FlexColumnWidth(0.2),
      },
      children: [
        TableRow(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                FlutterI18n.translate(context, 'tr.detail_info.$className.row_1'),
                style: Theme.of(context).textTheme.bodyMedium
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                row1,
                style: Theme.of(context).textTheme.bodyMedium
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                FlutterI18n.translate(context, 'tr.detail_info.$className.row_2'),
                style: Theme.of(context).textTheme.bodyMedium
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                row2,
                style: Theme.of(context).textTheme.bodyMedium
              ),
            ),
          ]
        ),
        TableRow(
          children: [
            Text(
              FlutterI18n.translate(context, 'tr.detail_info.$className.row_3'),
              style: Theme.of(context).textTheme.bodyMedium
            ),
            Text(
              row3,
              style: Theme.of(context).textTheme.bodyMedium
            ),
            Text(
              FlutterI18n.translate(context, 'tr.detail_info.$className.row_4'),
              style: Theme.of(context).textTheme.bodyMedium
            ),
            Text(
              row4,
              style: Theme.of(context).textTheme.bodyMedium
            ),
          ]
        )
      ],
    );
  }
}
