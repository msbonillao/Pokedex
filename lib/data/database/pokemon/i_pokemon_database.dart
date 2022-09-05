import 'package:pokedex_flutter/domain/models/pokemon.dart';
import 'package:pokedex_flutter/domain/models/pokemon_species.dart';

abstract class PokemonDatabase {
  Future<Pokemon?> fetchPokemonByID(covariant Object id);

  Future<PokemonSpecies?> fetchPokemonSpeciesByID(covariant Object id);

  Future<void> savePokemonDetail(Pokemon pokemon);

  Future<void> savePokemonSpecies(PokemonSpecies species);
}
