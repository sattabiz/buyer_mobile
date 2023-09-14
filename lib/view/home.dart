import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widget/index_list_tile.dart';

class Home extends StatelessWidget {
const Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Material(
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) => 
          IndexListTile(
            title: 'Headline',
            subtitle: 'Subtitle',
            svgPath: 'assets/alert.svg',
            onTap: ()  => context.go('/home/detail')
          ),
      ),
    );
  }
}