import '../database_manager.dart';
import 'i_pokemon_database.dart';
import '../../../domain/models/media/image_media.dart';
import '../../../domain/models/media/media.dart';
import '../../../domain/models/pokemon.dart';
import '../../../domain/models/pokemon_species.dart';
import '../../../domain/models/pokemon_sprite.dart';
import '../../../domain/models/pokemon_type.dart';
import '../../../domain/models/sprite.dart';
import '../../../utils/functions/base_parsing.dart';
import 'package:sembast/sembast.dart';

class PokemonDatabaseImpl implements PokemonDatabase {
  final DatabaseManager db;
  final store = stringMapStoreFactory.store('pokemon');
  final speciesStore = StoreRef('species');
  final pokedexStore = StoreRef('pokedex');

  PokemonDatabaseImpl({required this.db});

  Future<Pokemon?> fetchPokemonByID(covariant Object id) async {
    final pokemon = await store.record(id.toString()).get(db.db);
    return _PokemonDatabaseExtension.fromDatabase(pokemon);
  }

  Future<void> savePokemonDetail(Pokemon pokemon) async {
    final record = pokemon.toDatabase();
    store.record(pokemon.id!.toString()).put(db.db, record);
  }

  Future<PokemonSpecies?> fetchPokemonSpeciesByID(covariant Object id) async {
    return null;
  }

  Future<void> savePokemonSpecies(PokemonSpecies species) async {}


}

extension _PokemonDatabaseExtension on Pokemon {
  static Pokemon? fromDatabase(Map<String, dynamic>? map) {
    if (map == null) return null;
    return Pokemon(
      name: map['name'],
      id: map['id'],
      types: BaseParsing.parseList(
        data: map['types'],
        parser: _PokemonTypeDatabaseExtension.fromDatabase,
      ),
      sprites: _PokemonSpriteDatabaseExtension.fromDatabase(map['sprites']),
    );
  }

  Map<String, dynamic> toDatabase() {
    return {
      'name': name,
      'id': id,
      'types': types?.map((e) => e.toDatabase()).toList(),
      'sprites': sprites?.toDatabase(),
      // 'species': species?.toDatabase(),
    };
  }
}

extension _PokemonTypeDatabaseExtension on PokemonType {
  static PokemonType fromDatabase(Map<String, dynamic> map) {
    return PokemonType(
      label: map['label'],
      id: map['id'],
    );
  }

  Map<String, dynamic> toDatabase() {
    return {
      'label': label,
      'id': id,
    };
  }
}

extension _PokemonSpriteDatabaseExtension on PokemonSprites {
  Map<String, dynamic> toDatabase() {
    return {
      'defaultMedia': defaultMedia?.toDatabase(),
      'dreamWorld': dreamWorld?.toDatabase(),
      'home': home?.toDatabase(),
      'artwork': artwork?.toDatabase(),
    };
  }

  static PokemonSprites? fromDatabase(Map<String, dynamic>? map) {
    if (map == null) return null;
    return PokemonSprites(
      defaultMedia: SpriteDatabaseExtension.fromDatabase(map['defaultMedia']),
      dreamWorld: SpriteDatabaseExtension.fromDatabase(map['dreamWorld']),
      home: SpriteDatabaseExtension.fromDatabase(map['home']),
      artwork: SpriteDatabaseExtension.fromDatabase(map['artwork']),
      generationSprite: null,
    );
  }
}

extension SpriteDatabaseExtension on Sprite {
  Map<String, dynamic> toDatabase() {
    return {
      'backDefault': backDefault?.toDatabase(),
      'backFemale': backFemale?.toDatabase(),
      'backShiny': backShiny?.toDatabase(),
      'backShinyFemale': backShinyFemale?.toDatabase(),
      'frontDefault': frontDefault?.toDatabase(),
      'frontFemale': frontFemale?.toDatabase(),
      'frontShiny': frontShiny?.toDatabase(),
      'frontShinyFemale': frontShinyFemale?.toDatabase(),
    };
  }

  static Sprite? fromDatabase(Map<String, dynamic>? map) {
    if (map == null) return null;
    return Sprite(
      backDefault: MediaDatabaseExtension.fromDatabase(map['backDefault']),
      backFemale: MediaDatabaseExtension.fromDatabase(map['backFemale']),
      backShiny: MediaDatabaseExtension.fromDatabase(map['backShiny']),
      backShinyFemale:
          MediaDatabaseExtension.fromDatabase(map['backShinyFemale']),
      frontDefault: MediaDatabaseExtension.fromDatabase(map['frontDefault']),
      frontFemale: MediaDatabaseExtension.fromDatabase(map['frontFemale']),
      frontShiny: MediaDatabaseExtension.fromDatabase(map['frontShiny']),
      frontShinyFemale:
          MediaDatabaseExtension.fromDatabase(map['frontShinyFemale']),
    );
  }
}

extension MediaDatabaseExtension on Media {
  Map<String, dynamic> toDatabase() {
    return {
      'url': url,
    };
  }

  static Media? fromDatabase(Map<String, dynamic>? map) {
    if (map == null) return null;
    return ImageMedia(map['url']);
  }
}
