import 'package:pokedex_flutter/data/database/model/pokemon_species_db_extension.dart';

import '../database_manager.dart';
import '../model/pokemon_db_extension.dart';
import 'i_pokemon_database.dart';
import '../../../domain/models/pokemon.dart';
import '../../../domain/models/pokemon_species.dart';
import 'package:sembast/sembast.dart';

class PokemonDatabaseImpl implements PokemonDatabase {
  final DatabaseManager db;
  final store = stringMapStoreFactory.store('pokemon');
  final speciesStore = StoreRef('species');
  final pokedexStore = StoreRef('pokedex');

  PokemonDatabaseImpl({required this.db});

  Future<Pokemon?> fetchPokemonByID(covariant Object id) async {
    final pokemon = await store.record(id.toString()).get(db.db);
    return PokemonDatabaseExtension.fromDatabase(pokemon);
  }

  Future<void> savePokemonDetail(Pokemon pokemon) async {
    final record = pokemon.toDatabase();
    store.record(pokemon.id!.toString()).put(db.db, record);
  }

  Future<PokemonSpecies?> fetchPokemonSpeciesByID(covariant Object id) async {
    final species = await speciesStore.record(id.toString()).get(db.db);
    return PokemonSpeciesDatabaseExtension.fromDatabase(species);
  }

  Future<void> savePokemonSpecies(PokemonSpecies species) async {
    final record = species.toDatabase();
    speciesStore.record(species.id).put(db.db, record);
  }
}
