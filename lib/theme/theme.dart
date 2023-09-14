import 'package:flutter/material.dart';
import '/theme/theme_colors.dart';

ThemeData theme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: themeColor,
  unselectedWidgetColor: themeColor.onSurfaceVariant,
);

