import 'package:dio/dio.dart';
import 'package:pokedex_flutter/data/api/pokedex/i_pokedex_network_source.dart';
import 'package:pokedex_flutter/domain/errors/server_error.dart';

import '../../../domain/models/pokedex.dart';
import '../api_parsing.dart';

class PokedexNetworkSourceImpl implements PokedexNetworkSource {
  final Dio client;

  PokedexNetworkSourceImpl(this.client);

  @override
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
