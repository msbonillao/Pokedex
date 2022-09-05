// ignore_for_file: unused_import

import 'package:pokedex_flutter/data/api/model/genera.dart';
import 'package:pokedex_flutter/data/api/model/pokemon_name.dart';
import 'package:pokedex_flutter/domain/models/flavor_text.dart';

class PokemonSpecies {
   final int? baseHappiness;
  final int? captureRate;
  final String name;
  final List<VersionableValue<String>>? flavorTexts;
  final String? genera;

  PokemonSpecies({
    this.baseHappiness,
    this.captureRate,
    required this.name,
    required this.flavorTexts,
    required this.genera,
  });
}
