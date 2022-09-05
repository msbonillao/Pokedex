import 'pokemon_entry.dart';

class Pokedex {
  final Object id;
  final String description;
  final String name;
  final List<PokemonEntry> pokemonEntries;

  Pokedex({
    required this.id,
    required this.description,
    required this.name,
    required this.pokemonEntries,
  });
}
