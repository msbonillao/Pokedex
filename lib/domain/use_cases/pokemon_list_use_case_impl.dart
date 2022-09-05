import 'package:pokedex_flutter/data/repositories/pokedex/i_pokedex_repository.dart';
import 'package:pokedex_flutter/domain/models/pokedex.dart';
import 'package:pokedex_flutter/domain/use_cases/interfaces/pokemon_list_use_case.dart';

class PokemonListUseCaseImpl implements PokemonListUseCase {
  PokemonListUseCaseImpl({
    required this.repository,
  });

  final PokedexRepository repository;

  @override
  Future<Pokedex> getPokedex(Object id) {
    return repository.fetchPokedex(id);
  }
}
