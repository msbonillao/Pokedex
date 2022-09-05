import 'package:pokedex_flutter/data/database/index/index_database.dart';
import 'package:pokedex_flutter/data/repositories/pokedex/i_pokedex_repository.dart';
import 'package:pokedex_flutter/domain/models/pokedex.dart';
import 'package:pokedex_flutter/domain/models/pokemon_entry.dart';
import 'package:pokedex_flutter/domain/use_cases/interfaces/pokemon_index_use_case.dart';

const NATIONAL_POKEDEX = 1;

class IndexUseCaseImpl implements PokemonIndexUseCase {
  final PokedexRepository pokedexRepository;

  final IndexDatabase indexRepository;

  IndexUseCaseImpl({
    required this.pokedexRepository,
    required this.indexRepository,
  });

  @override
  Future<void> createIndex(List<PokemonEntry> entries) {
    return indexRepository.createIndex(entries);
  }

  @override
  Future<Pokedex> fetchIndex() {
    return pokedexRepository.fetchPokedex(NATIONAL_POKEDEX);
  }

  @override
  Future<int> countCurrentIndex() {
    return indexRepository.readIndex();
  }
}
