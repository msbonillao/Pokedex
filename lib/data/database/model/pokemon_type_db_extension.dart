import 'package:pokedex_flutter/domain/models/pokemon_type.dart';

extension PokemonTypeDatabaseExtension on PokemonType {
  static PokemonType fromDatabase(Map<String, dynamic> map) {
    return PokemonType(
      label: map['label'],
      id: map['id'],
    );
  }

  Map<String, dynamic> toDatabase() {
    return {
      'label': label,
      'id': id,
    };
  }
}
