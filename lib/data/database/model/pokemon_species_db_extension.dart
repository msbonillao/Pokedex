import 'package:pokedex_flutter/data/database/model/versionable_value_database_extension.dart';
import 'package:pokedex_flutter/domain/models/pokemon_species.dart';
import 'package:pokedex_flutter/utils/functions/base_parsing.dart';

extension PokemonSpeciesDatabaseExtension on PokemonSpecies {
  Map<String, dynamic> toDatabase() => {
        'base_happiness': baseHappiness,
        'captureRate': captureRate,
        'name': name,
        'genera': genera,
        'flavor_text': flavorTexts?.map((e) => e.toDatabase()).toList(),
        'id': id,
      };

  static PokemonSpecies? fromDatabase(Map<String, dynamic>? map) {
    if (map == null) return null;
    return PokemonSpecies(
      id: map['id'],
      name: map['name'],
      flavorTexts: BaseParsing.parseList(
        data: map['flavor_text'],
        parser: VersionableValueDatabaseExtension.fromDatabase,
      ),
      genera: map['genera'],
      captureRate: map['captureRate'],
      baseHappiness: map['baseHappiness'],
    );
  }
}
