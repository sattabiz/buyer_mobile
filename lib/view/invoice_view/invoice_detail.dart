import 'package:flutter/material.dart';
import '../../utils/widget_helper.dart';
import '../widget/app_bar/top_app_bar_left.dart';
import '../widget/detail_components/detail_info.dart';
import '../widget/detail_components/detail_table.dart';
import '../widget/detail_components/detail_table_panel.dart';

class InvoiceDetail extends StatelessWidget {
  const InvoiceDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: TopAppBarLeft(
        title: 'Fatura: GIB1533',
        icon: Icons.chat_bubble_outline,
        route: '/invoice',
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).colorScheme.onSecondary,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "Yolda",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color:
                        Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
              SizedBox(
                width: width,
                child: const DetailInfo(
                  className: 'invoice',
                  row1: "15.01.2023",
                  row2: "18.03.2023",
                  row3: "355",
                  row4: "Cari Hesap",
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                width: width,
                padding: const EdgeInsets.all(5.0),
                child: DetailTable(),
              ),
              SizedBox(
                width: width,
                height: 100,
                child: DetailTablePanel(
                  productList: productList, 
                  isFileAttached: false, 
                  isPending: true
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
