import 'package:pokedex_flutter/domain/models/pokemon_species.dart';
import 'package:pokedex_flutter/domain/models/pokemon_sprite.dart';
import 'package:pokedex_flutter/domain/models/pokemon_type.dart';

class Pokemon {
  final String? name;
  final Object? id;
  final List<PokemonType>? types;
  final PokemonSprites? sprites;
  final PokemonSpecies? species;

  Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.sprites,
    this.species,
  });

  Pokemon copyWith({
    String? name,
    Object? id,
    List<PokemonType>? types,
    PokemonSprites? sprites,
    PokemonSpecies? species,
  }) {
    return Pokemon(
      id: id ?? this.id,
      name: name ?? this.name,
      types: types ?? this.types,
      sprites: sprites ?? this.sprites,
      species: species ?? this.species,
    );
  }
}
