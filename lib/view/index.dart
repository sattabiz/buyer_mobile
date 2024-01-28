import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Index extends ConsumerWidget {
  final PreferredSizeWidget ?customAppBar;
  final Widget ?bottomNavigationBar;

  const Index(this.navigationShell, this.customAppBar, this.bottomNavigationBar, {Key? key}) : super(key: key);

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async{
          return false;
        },
      child: Scaffold(
        appBar: customAppBar,
        body: navigationShell,
        bottomNavigationBar: bottomNavigationBar,
        resizeToAvoidBottomInset: true,
      ),
    );
  }
}
