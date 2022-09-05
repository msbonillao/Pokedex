import 'package:pokedex_flutter/domain/models/pokemon.dart';
import 'package:pokedex_flutter/utils/functions/base_parsing.dart';

import 'pokemon_sprite_db_extension.dart';
import 'pokemon_type_db_extension.dart';

extension PokemonDatabaseExtension on Pokemon {
  static Pokemon? fromDatabase(Map<String, dynamic>? map) {
    if (map == null) return null;
    return Pokemon(
      name: map['name'],
      id: map['id'],
      types: BaseParsing.parseList(
        data: map['types'],
        parser: PokemonTypeDatabaseExtension.fromDatabase,
      ),
      sprites: PokemonSpriteDatabaseExtension.fromDatabase(map['sprites']),
    );
  }

  Map<String, dynamic> toDatabase() {
    return {
      'name': name,
      'id': id,
      'types': types?.map((e) => e.toDatabase()).toList(),
      'sprites': sprites?.toDatabase(),
      // 'species': species?.toDatabase(),
    };
  }
}