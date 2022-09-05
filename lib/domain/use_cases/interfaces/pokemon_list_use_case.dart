import 'package:pokedex_flutter/domain/models/pokedex.dart';

import 'use_case.dart';

abstract class PokemonListUseCase implements UseCase {
  Future<Pokedex> getPokedex(Object id);
}
