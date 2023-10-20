import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class ShowProposalInfo extends StatelessWidget {
  final String row1;
  final String row2;
  final String row3;
  final String row4;
  final String row5;
  final Widget row6;

  const ShowProposalInfo({
    Key? key,
    required this.row1,
    required this.row2,
    required this.row3,
    required this.row4,
    required this.row5,
    required this.row6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                FlutterI18n.translate(context, 'tr.detail_info.proposal.row_1'),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold
                )
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                FlutterI18n.translate(context, 'tr.detail_info.proposal.row_2'),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold
                )
              ),
            ),
          ]
        ),
        TableRow(
          children: [
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
                row2, 
                style: Theme.of(context).textTheme.bodyMedium
              ),
            ),
          ]
        ),
        TableRow(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                FlutterI18n.translate(context, 'tr.detail_info.proposal.row_3'),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold
                )
              ),
            ),
            Text(
              FlutterI18n.translate(context, 'tr.detail_info.proposal.row_4'),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold
              )
            ),
          ]
        ),
        TableRow(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                row3, 
                style: Theme.of(context).textTheme.bodyMedium
              ),
            ),
            Text(
              row4, 
              style: Theme.of(context).textTheme.bodyMedium
            ),
          ]
        ),
        TableRow(
          children: [
            Text(
              FlutterI18n.translate(context, 'tr.detail_info.proposal.row_5'),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold
              )
            ),
            Text(
              FlutterI18n.translate(context, 'tr.detail_info.proposal.row_6'),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold
              )
            ),
          ]
        ),
        TableRow(
          children: [
            Text(
              row5, 
              style: Theme.of(context).textTheme.bodyMedium
            ),
            row6,
          ]
        )
      ],
    );
  }
}
