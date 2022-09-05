import 'package:pokedex_flutter/data/api/api_parsing.dart';
import 'package:pokedex_flutter/domain/models/api_resource.dart';
import 'package:pokedex_flutter/data/api/pokemon/i_pokemon_network_source.dart';
import 'package:pokedex_flutter/domain/errors/server_error.dart';
import 'package:pokedex_flutter/domain/models/models.dart';
import 'package:pokedex_flutter/domain/models/pokedex.dart';
import 'package:pokedex_flutter/domain/models/pokemon.dart';
import 'package:dio/dio.dart';
import 'package:pokedex_flutter/domain/models/pokemon_species.dart';
import 'package:pokedex_flutter/utils/functions/base_parsing.dart';

class PokemonNetworkSourceImpl implements PokemonNetworkSource {
  final Dio client;

  PokemonNetworkSourceImpl({
    required this.client,
  });

  @override
  Future<Pokemon> fetchPokemonByID(String id) async {
    final response = await client.get('/pokemon/$id');
    if (response.statusCode == 200) {
      return APIParsing.pokemonFromJson(response.data);
    }
    throw ServerError(response.statusCode.toString());
  }

  @override
  Future<List<APIResource>> fetchPokemonList({
    required int resultsPerPage,
    required int page,
  }) async {
    final response = await client.get(
      '/pokemon/',
      queryParameters: {
        'limit': resultsPerPage,
        'offset': page * resultsPerPage,
      },
    );
    if (response.statusCode == 200) {
      final pokemons = response.data?['results'];
      return BaseParsing.parseList(
        data: pokemons,
        parser: APIParsing.apiResourceFromJson,
      );
    }
    throw ServerError(response.statusCode.toString());
  }

  @override
  Future<PokemonSpecies> fetchPokemonSpeciesByID(covariant Object id) async {
    final response = await client.get('/pokemon-species/$id');
    if (response.statusCode == 200) {
      return APIParsing.speciesFromJson(response.data);
    }
    throw ServerError(response.statusCode.toString());
  }

  Future<Pokedex> fetchPokedex(Object id) async {
    final response = await client.get(
      '/pokedex/$id',
    );
    if (response.statusCode == 200) {
      return APIParsing.pokedexFromJson(response.data);
    }
    throw ServerError(response.statusCode.toString());
  }
}
