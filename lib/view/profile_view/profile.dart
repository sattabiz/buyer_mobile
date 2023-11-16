import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../view_model/current_user_view_model.dart';
import '../../view_model/logout_view_model.dart';
import '../widget/app_bar/top_app_bar_centered.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final currentUser = ref.watch(getCurrentUserInfoProvider);
    // final String? route = GoRouterState.of(context).fullPath;
    // debugPrint(route.toString());
    return currentUser.when(
      data: (data) {
        return Scaffold(
          key: _scaffoldKey,
          endDrawerEnableOpenDragGesture: false,
          appBar:  TopAppBarCentered(
            title: FlutterI18n.translate(context, 'tr.login.sign_up_page.profile'),
            backRoute: "/home",
            openDrawer: true,
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).colorScheme.onSecondary,
            child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    height: height - 200,
                    child: SvgPicture.asset(
                      'assets/svg/profile_bg.svg',
                      fit: BoxFit.cover,
                      // height: height - 200,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        FlutterI18n.translate(
                            context, 'tr.login.sign_up_page.name'),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        data.currentUser!.fullName.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        FlutterI18n.translate(
                            context, 'tr.login.sign_up_page.firm'),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        data.company!.name.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        FlutterI18n.translate(
                            context, 'tr.login.sign_up_page.address'),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        data.company!.address.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        FlutterI18n.translate(
                            context, 'tr.login.sign_up_page.city'),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        data.company!.city.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        FlutterI18n.translate(
                            context, 'tr.login.sign_up_page.phone_number'),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        data.company!.phone.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        FlutterI18n.translate(
                            context, 'tr.login.sign_up_page.tax_center'),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        data.company!.taxOffice.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        FlutterI18n.translate(
                            context, 'tr.login.sign_up_page.tax_no'),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        data.company!.taxId.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
          ),
          endDrawer: NavigationDrawer(
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Text(
                      FlutterI18n.translate(context, 'tr.profile.settings'),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 50),
                    Text(
                      FlutterI18n.translate(context, 'tr.profile.contract'),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      FlutterI18n.translate(context, 'tr.profile.open_contract'),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () async {
                        final logoutViewModel =ref.read(logoutViewModelProvider.notifier);
                        await logoutViewModel.logout();
                        context.go('/login');
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).colorScheme.primary),
                        fixedSize:
                            MaterialStateProperty.all<Size>(const Size(140, 30)),
                      ),
                      child: Text(
                        FlutterI18n.translate(context, 'tr.profile.logout'),
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => const Center(child: Text('Error')),
    );
  }
}
