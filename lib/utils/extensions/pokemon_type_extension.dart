import 'package:flutter/material.dart';
import 'package:pokedex_flutter/UI/utils/type_colors.dart';
import 'package:pokedex_flutter/domain/models/models.dart';

extension PokemonTypeExtension on PokemonType {
  Color get color => pokemonTypeColors[id] ?? Colors.grey;
}
