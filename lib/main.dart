import 'package:buyer_mobile/theme/theme.dart';
import 'package:buyer_mobile/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/loaders/decoders/yaml_decode_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp()
    ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme:theme,
      localizationsDelegates: [
        FlutterI18nDelegate(
          missingTranslationHandler: (key, locale) {
          },
          translationLoader: FileTranslationLoader(
              fallbackFile: 'tr',
              basePath: 'assets/flutter_i18n',
              forcedLocale: const Locale('tr'),
              decodeStrategies: [YamlDecodeStrategy()],
              useCountryCode: false),
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
    );
  }
}
