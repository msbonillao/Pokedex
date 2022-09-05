import 'package:pokedex_flutter/domain/models/api_resource.dart';

class PokemonVersion implements APIResource {
  const PokemonVersion(this.id);

  @override
  final String id;

  @override
  String get resource => 'version';
}
