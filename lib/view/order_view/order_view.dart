import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widget/index_list_tile.dart';

class OrderView extends StatelessWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) => IndexListTile(
        title: 'Headline',
        subtitle: 'Subtitle',
        svgPath: 'assets/alert.svg',
        trailing: const Icon(
          Icons.shape_line
          ),
        onTap: () => context.go('/order/detail'),
      ),
    );
  }
}
