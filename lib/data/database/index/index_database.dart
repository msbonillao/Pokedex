import 'package:pokedex_flutter/data/database/database_manager.dart';
import 'package:pokedex_flutter/domain/models/pokemon_entry.dart';
import 'package:sembast/sembast.dart';

class IndexDatabase {
  final DatabaseManager databaseManager;

  final store = stringMapStoreFactory.store('index');

  IndexDatabase(this.databaseManager);

  Future<void> createIndex(List<PokemonEntry> entries) async {
    final records = entries.map((entry) =>
        store.record(entry.id).put(databaseManager.db, entry.toDatabase()));

    await Future.wait(records);
  }

  Future<List<PokemonEntry>?> search(String index) async {
    final finder = Finder(filter: Filter.matches('name', index));
    final records = await store.find(databaseManager.db, finder: finder);
    return records
        .map((e) => _PokemonEntryDatabase.fromDatabase(e.value))
        .toList();
  }

  Future<int> readIndex()async {
    return await store.count(databaseManager.db);
  }
}

extension _PokemonEntryDatabase on PokemonEntry {
  Map<String, dynamic> toDatabase() => {
        'id': id,
        'name': name,
        'resource': resource,
      };

  static PokemonEntry fromDatabase(Map<String, dynamic> map) {
    return PokemonEntry(
        id: map['id'], resource: map['resource'], name: map['name']);
  }
}
