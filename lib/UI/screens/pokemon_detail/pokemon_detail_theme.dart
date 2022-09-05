import 'package:flutter/material.dart';

class PokemonDetailTheme {
  static TextStyle pokemonTitleStyle(BuildContext context) => TextStyle(
        fontSize: 32,
        color: Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeight.bold,
      );
}
