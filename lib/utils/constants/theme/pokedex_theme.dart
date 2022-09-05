import 'package:flutter/material.dart';
import 'package:pokedex_flutter/utils/constants/styles/text_styles.dart';

class PokedexTheme {
  static final theme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TextTheme(
      headline6: PokedexTexStyles.baseFont,
      bodyText1: PokedexTexStyles.baseFont.copyWith(
        fontWeight: FontWeight.w600,
      ),
      bodyText2: PokedexTexStyles.baseFont,
    ),
  );
}
