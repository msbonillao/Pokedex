import 'package:pokedex_flutter/domain/models/pokedex.dart';

abstract class IPokemonSearchUseCase {
  Future<Pokedex> getPokedex(Object id);

}