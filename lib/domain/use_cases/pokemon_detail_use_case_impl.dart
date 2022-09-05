import '../../data/repositories/pokemon/i_pokemon_repository.dart';
import '../models/pokemon.dart';
import '../models/pokemon_species.dart';
import 'interfaces/pokemon_detail_use_case.dart';

class PokemonDetailUseCaseImpl implements PokemonDetailUseCase {
  PokemonDetailUseCaseImpl({required this.repository});

  final PokemonRepository repository;

  @override
  Future<Pokemon> getPokemon(Object id) {
    return repository.fetchPokemonByID(id);
  }

  @override
  Future<PokemonSpecies> getPokemonSpecies(Object id) {
    return repository.fetchPokemonSpeciesByID(id);
  }
}
