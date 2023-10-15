import 'package:flutter/material.dart';
import '/theme/theme_colors.dart';

ThemeData theme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: themeColor,
  unselectedWidgetColor: themeColor.primaryContainer,
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: themeColor.primaryContainer,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.all(themeColor.primaryContainer.withOpacity(0.4)),
    )
  )
);

