import 'package:pokedex_flutter/domain/models/sprite.dart';
import 'media_db_extension.dart';

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
