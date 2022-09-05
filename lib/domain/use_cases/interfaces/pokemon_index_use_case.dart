import 'package:pokedex_flutter/domain/models/pokedex.dart';

import '../../models/pokemon_entry.dart';

abstract class PokemonIndexUseCase {
  Future<void> createIndex(List<PokemonEntry> entries);
  Future<Pokedex> fetchIndex();
  Future<int> countCurrentIndex();

}