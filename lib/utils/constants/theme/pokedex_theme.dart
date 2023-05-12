import 'package:flutter/material.dart';
import 'package:pokedex_flutter/utils/constants/styles/text_styles.dart';

class PokedexTheme {
  static final theme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TextTheme(
      titleLarge: PokedexTexStyles.baseFont,
      bodyLarge: PokedexTexStyles.baseFont.copyWith(
        fontWeight: FontWeight.w600,
        overflow: TextOverflow.ellipsis,
      ),
      bodyMedium: PokedexTexStyles.baseFont,
    ),

  );
}
