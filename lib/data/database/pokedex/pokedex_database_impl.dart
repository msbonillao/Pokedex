import 'pokedex_database.dart';
import '../../../domain/models/pokemon_entry.dart';

import '../database_manager.dart';
import '../../../domain/models/pokedex.dart';
import '../../../utils/functions/base_parsing.dart';
import 'package:sembast/sembast.dart';

class PokedexDatabaseImpl implements PokedexDatabase {
  final DatabaseManager db;
  final pokedexStore = stringMapStoreFactory.store('pokedex');

  PokedexDatabaseImpl(this.db);

  void clearCache() {
    pokedexStore.delete(db.db);
  }

  void savePokedex(Pokedex pokedex) {
    final record = pokedex.toDatabase();
    pokedexStore.record(pokedex.id.toString()).put(db.db, record);
  }

  Future<Pokedex?> fetchPokedexById(Object id) async {
    final record = await pokedexStore.record(id.toString()).get(db.db);
    return _PokedexDatabaseParsing.fromDatabase(record);
  }

}

extension _PokedexDatabaseParsing on Pokedex {
  Map<String, dynamic> toDatabase() =>
      {
        "id": id.toString(),
        "description": description,
        "name": name,
        "entries": pokemonEntries.map((entry) => entry.toDatabase()).toList(),
      };

  static Pokedex? fromDatabase(Map<String, dynamic>? map) {
    if (map == null) return null;
    return Pokedex(
      id: map['id'],
      description: map['description'],
      name: map['name'],
      pokemonEntries: BaseParsing.parseList(
        data: map['entries'],
        parser: _PokemonEntryDatabaseExtension.fromDatabase,
      ),
    );
  }
}

extension _PokemonEntryDatabaseExtension on PokemonEntry {
  Map<String, dynamic> toDatabase() =>
      {
        "id": id,
        "resource": resource,
        'name': name,
      };

  static PokemonEntry fromDatabase(Map<String, dynamic> map) =>
      PokemonEntry(
        id: map['id'],
        name: map['name'],
        resource: map['resource'],
      );
}
