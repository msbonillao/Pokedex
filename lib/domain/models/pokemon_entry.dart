import 'package:pokedex_flutter/domain/models/api_resource.dart';

class PokemonEntry implements APIResource {
  @override
  final String id;
  @override
  final String resource;
  final String name;

  PokemonEntry({
    required this.id,
    required this.resource,
    required this.name,
  });
}
