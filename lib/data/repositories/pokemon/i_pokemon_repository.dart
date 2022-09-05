import 'package:pokedex_flutter/domain/models/api_resource.dart';
import 'package:pokedex_flutter/domain/models/pokemon.dart';
import 'package:pokedex_flutter/domain/models/pokemon_species.dart';

abstract class PokemonRepository {
  Future<List<APIResource>> fetchPokemonList({int resultsPerPage, int page});

  Future<Pokemon> fetchPokemonByID(covariant Object id);

  Future<PokemonSpecies> fetchPokemonSpeciesByID(covariant Object id);
}
