import 'package:buyer_mobile/view/login_view/login.view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../view/home.dart';
import '../view/index.dart';
import '../view/invoice_view/generate_invoice.dart';
import '../view/invoice_view/invoice_detail.dart';
import '../view/invoice_view/invoice_view.dart';
import '../view/invoice_view/ready_for_ship.dart';
import '../view/order_view/order_detail.dart';
import '../view/order_view/order_view.dart';
import '../view/order_view/ready_for_ship_detail.dart';
import '../view/proposal_view/proposal_detail.dart';
import '../view/proposal_view/proposal_view.dart';
import '../view/widget/app_bar/top_app_bar_centered.dart';
import '../view/widget/app_bar/top_app_bar_large.dart';
import '../view/widget/chat_box.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',
  routes: <RouteBase>[
    GoRoute(
      path: '/login',
      builder: (context, state) => Login(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Index(
          navigationShell,
          customAppBar(state.matchedLocation),
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _sectionNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: '/home',
              builder: (context, state) => const Home(),
              routes: <RouteBase>[
                GoRoute(
                  path: 'detail',
                  pageBuilder: (context, state) => MaterialPage(
                    child: Container(
                      key: state.pageKey,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        StatefulShellBranch(routes: <RouteBase>[
          GoRoute(
            path: '/proposal',
            builder: (context, state) => const ProposalView(),
            routes: <RouteBase>[
              GoRoute(
                path: 'detail',
                redirect: (context, state) => '/proposal_detail',
              ),
            ],
          ),
        ]),
        StatefulShellBranch(routes: <RouteBase>[
          GoRoute(
            path: '/order',
            builder: (context, state) => const OrderView(),
            routes: <RouteBase>[
              GoRoute(
                path: 'detail',
                redirect: (context, state) => '/order_detail',
                // routes: <RouteBase>[
                //   // GoRoute(
                //   //   path: 'chat',
                //   //   builder: (context, state) => const ChatBox(),
                //   // ),
                //   // GoRoute(
                //   //   path: 'ready',
                //   //   builder: (context, state){
                //   //     debugPrint(state.matchedLocation);
                //   //     throw UnimplementedError();
                //   //   }
                //   // )
                // ],
              ),
            ],
          ),
        ]),
        StatefulShellBranch(routes: <RouteBase>[
          GoRoute(
            path: '/invoice',
            builder: (context, state) => const InvoiceView(),
            routes: <RouteBase>[
              GoRoute(
                path: 'detail',
                redirect: (context, state) => '/invoice_detail',
                routes: <RouteBase>[
                  GoRoute(
                    path: 'chat',
                    builder: (context, state) => const ChatBox(),
                  ),
                ],
              ),
              GoRoute(
                path: 'invoice_ready',
                builder: (context, state) => ReadyForShipInvoice(),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'generate',
                    builder: (context, state) => const GenerateInvoice(),
                  ),
                ],
              ),
            ],
          ),
        ])
      ],
    ),
    GoRoute(
      path: '/home_detail',
      builder: (context, state) => Container(
        key: state.pageKey,
        color: Colors.white,
      ),
    ),
    GoRoute(
      path: '/proposal_detail',
      builder: (context, state) => ProposalDetail(
        key: state.pageKey,
      ),
    ),
    GoRoute(
      path: '/order_detail',
      builder: (context, state) => OrderDetail(
        key: state.pageKey,
      ),
    ),
    GoRoute(
      path: '/invoice_detail',
      builder: (context, state) => InvoiceDetail(
        key: state.pageKey,
      ),
    ),
    GoRoute(
      path: '/invoice_ready',
      builder: (context, state) => ReadyForShipInvoice(
        key: state.pageKey,
      ),
    ),
    GoRoute(
      path: '/invoice_ready/generate',
      builder: (context, state) => GenerateInvoice(
        key: state.pageKey,
      ),
    ),
    GoRoute(
      path: '/order_detail/ready',
      builder: (context, state) => ReadyForShipDetail(
        key: state.pageKey,
      ),
    )
  ],
);

PreferredSizeWidget customAppBar(String location) {
  PreferredSizeWidget customAppBar;
  switch (location) {
    case '/home':
      customAppBar = const PreferredSize(
        preferredSize: Size(double.infinity, 110),
        child: TopAppBarLarge(
          title: 'Palet Point',
        ),
      );
      break;
    case '/home/detail':
      customAppBar = const PreferredSize(
        preferredSize: Size(double.infinity, 110),
        child: TopAppBarLarge(
          title: 'Palet Point',
        ),
      );
      break;
    case '/proposal':
      customAppBar = CustomAppBar(
        height: kToolbarHeight,
        child: const TopAppBarCentered(
          title: 'Teklif İstekleri',
          route: '/home',
        ),
      );
      break;
    case '/order':
      customAppBar = CustomAppBar(
        height: kToolbarHeight,
        child: const TopAppBarCentered(
          title: 'SİPARİŞLER',
          route: '/proposal',
        ),
      );
      break;
    case '/invoice':
      customAppBar = CustomAppBar(
        height: kToolbarHeight,
        child: const TopAppBarCentered(
          title: 'FATURALAR',
          route: '/order',
        ),
      );
      break;
    default:
      customAppBar = CustomAppBar(
        height: 110,
        child: const TopAppBarLarge(
          title: 'Palet Point',
        ),
      );
  }
  return customAppBar;
}
