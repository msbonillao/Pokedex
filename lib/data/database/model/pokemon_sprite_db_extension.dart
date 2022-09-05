import 'package:pokedex_flutter/domain/models/pokemon_sprite.dart';
import 'sprite_db_extension.dart';

extension PokemonSpriteDatabaseExtension on PokemonSprites {
  Map<String, dynamic> toDatabase() {
    return {
      'defaultMedia': defaultMedia?.toDatabase(),
      'dreamWorld': dreamWorld?.toDatabase(),
      'home': home?.toDatabase(),
      'artwork': artwork?.toDatabase(),
    };
  }

  static PokemonSprites? fromDatabase(Map<String, dynamic>? map) {
    if (map == null) return null;
    return PokemonSprites(
      defaultMedia: SpriteDatabaseExtension.fromDatabase(map['defaultMedia']),
      dreamWorld: SpriteDatabaseExtension.fromDatabase(map['dreamWorld']),
      home: SpriteDatabaseExtension.fromDatabase(map['home']),
      artwork: SpriteDatabaseExtension.fromDatabase(map['artwork']),
      generationSprite: null,
    );
  }
}
