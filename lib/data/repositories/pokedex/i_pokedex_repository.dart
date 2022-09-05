import 'package:pokedex_flutter/domain/models/pokedex.dart';

abstract class PokedexRepository {
  Future<Pokedex> fetchPokedex(Object id);
}
