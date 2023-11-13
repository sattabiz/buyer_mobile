import 'package:PaletPoint/view/login_view/forgot_password.dart';
import 'package:PaletPoint/view/login_view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../storage/jwt_storage.dart';
import '../view/home.dart';
import '../view/index.dart';
import '../view/invoice_view/generate_invoice.dart';
import '../view/invoice_view/invoice_detail.dart';
import '../view/invoice_view/invoice_view.dart';
import '../view/invoice_view/ready_for_ship.dart';
import '../view/login_view/sign_up.dart';
import '../view/order_view/order_detail.dart';
import '../view/order_view/order_view.dart';
import '../view/order_view/ready_for_ship_detail.dart';
import '../view/profile_view/profile.dart';
import '../view/proposal_view/proposal_detail.dart';
import '../view/proposal_view/proposal_view.dart';
import '../view/widget/app_bar/top_app_bar_large.dart';
import '../view/widget/bottom_navigation.dart';
import '../view/widget/chat_box.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',
  routes: <RouteBase>[
    GoRoute(
      path: '/login',
      redirect: (context, state) async {
        final _jwt = await jwtStorageService().getJwtData();
        if(_jwt.isEmpty == true){
          return '/login';
        }else{
          return '/home';
        }
      },
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      path: '/forgot_password',
      builder: (context, state) => const ForgotPassword(),
    ),
    GoRoute(
      path: '/sign_up',
      builder: (context, state) => const SignUp(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Index(
          navigationShell,
          customAppBar(state.matchedLocation, context),
          bottomNavigatonBar(state.matchedLocation, navigationShell));
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _sectionNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: '/home',
              builder: (context, state) => const Home(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/proposal',
              builder: (context, state) => const ProposalView(),
              routes: <RouteBase>[
                GoRoute(
                  name: 'proposal_detail',
                  path: 'detail/:proposalId',
                  builder: (context, state) => ProposalDetail(
                    key: state.pageKey,
                    proposalId: state.pathParameters['proposalId']!,
                  ),
                  routes: [
                    GoRoute(
                      name: 'proposal_chat',
                      path: 'chat/:chatId',
                      builder: (context, state) => ChatBox(
                        key: state.pageKey,
                        id: state.pathParameters['chatId']!,
                      ),
                    )
                  ]
                ),
              ],
            ),
          ]
        ),
        StatefulShellBranch(
          initialLocation: '/order', 
          routes: <RouteBase>[
            GoRoute(
              path: '/order',
              builder: (context, state) => const OrderView(),
              routes: <RouteBase>[
                GoRoute(
                  name: 'order_detail',
                  path: 'detail/:orderId',
                  builder: (context, state) => OrderDetail(
                    key: state.pageKey,
                    orderId: state.pathParameters['orderId']!,
                  ),
                  routes: [
                    GoRoute(
                      name: 'order_chat',
                      path: 'chat/:chatId',
                      builder: (context, state) => ChatBox(
                        key: state.pageKey,
                        id: state.pathParameters['chatId']!,
                      ),
                    ),
                    GoRoute(
                      path: 'ready',
                      builder: (context, state) => ReadyForShipDetail(
                        key: state.pageKey,
                      ),
                    ),
                  ]
                ),
              ],
            ),
          ]
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/invoice',
              builder: (context, state) => InvoiceView(
                key: state.pageKey,
              ),
              routes: <RouteBase>[
                GoRoute(
                  name: 'invoice_detail',
                  path: 'detail/:invoiceId',
                  builder: (context, state) => InvoiceDetail(
                    key: state.pageKey,
                  ),
                  routes: [
                    GoRoute(
                      name: 'invoice_chat',
                      path: 'chat/:chatId',
                      builder: (context, state) => ChatBox(
                        key: state.pageKey,
                        id: state.pathParameters['chatId']!,
                      ),
                    ),
                  ]
                ),
                GoRoute(
                  path: 'invoice_ready',
                  builder: (context, state) => ReadyForShipInvoice(
                    key: state.pageKey,
                  ),
                  routes: [
                    GoRoute(
                      name: 'invoice_ready_chat',
                      path: 'chat/:chatId',
                      builder: (context, state) => ChatBox(
                        key: state.pageKey,
                        id: state.pathParameters['chatId']!,
                      )
                    ),
                    GoRoute(
                      path: 'generate',
                      builder: (context, state) => GenerateInvoice(
                        key: state.pageKey,
                      ),
                    ),
                  ]
                ),
              ],
            ),
          ]
        ),
      ],
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => Profile(
        key: state.pageKey,
      ),
    )
  ],
);

Widget? bottomNavigatonBar(
  String location, StatefulNavigationShell navigationShell) {
    int currentIndex = navigationShell.currentIndex;
    Widget? bottomNavigation;
    void onTap(index) {
      navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );
    }

    if (location == '/home' ||
        location == '/proposal' ||
        location == '/order' ||
        location == '/invoice') {
      bottomNavigation =
          BottomNavigation(currentIndex: currentIndex, onItemTapped: onTap);
    } else {
      bottomNavigation = null;
    }
    return bottomNavigation;
}

PreferredSizeWidget? customAppBar(String location, BuildContext context) {
  PreferredSizeWidget? customAppBar;
  customAppBar = const PreferredSize(
    preferredSize: Size(double.infinity, 100),
    child: TopAppBarLarge(),
  );
  if (location == '/home' ||
      location == '/proposal' ||
      location == '/order' ||
      location == '/invoice') {
    return customAppBar;
  } else {
    return customAppBar = null;
  }
}
