import 'package:pokedex_flutter/data/database/pokemon/i_pokemon_database.dart';
import '../../../domain/models/api_resource.dart';
import '../../../domain/models/pokemon.dart';
import '../../../domain/models/pokemon_species.dart';
import '../../api/pokemon/i_pokemon_network_source.dart';
import 'i_pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonNetworkSource networkSource;
  final PokemonDatabase localSource;

  PokemonRepositoryImpl({
    required this.networkSource,
    required this.localSource,
  });

  @override
  Future<Pokemon> fetchPokemonByID(String id) async {
    Pokemon? pokemon = await localSource.fetchPokemonByID(id);
    if (pokemon == null) {
      pokemon = await networkSource.fetchPokemonByID(id);
      localSource.savePokemonDetail(pokemon);
    }
    return pokemon;
  }

  @override
  Future<List<APIResource>> fetchPokemonList(
      {int resultsPerPage = 20, int page = 0}) {
    return networkSource.fetchPokemonList(
        resultsPerPage: resultsPerPage, page: page);
  }

  @override
  Future<PokemonSpecies> fetchPokemonSpeciesByID(covariant Object id) {
    return networkSource.fetchPokemonSpeciesByID(id);
  }
}
