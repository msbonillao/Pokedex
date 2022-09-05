import 'package:pokedex_flutter/data/api/model/language.dart';
import 'package:pokedex_flutter/data/api/model/language_resource.dart';

class PokemonGenera extends LanguageResource<String> {
  final ApiLanguage language;

  final String value;

  PokemonGenera({
    required this.language,
    required this.value,
  });

  factory PokemonGenera.fromJson(Map<String, dynamic> data) => PokemonGenera(
        language: ApiLanguage.fromJson(data['language']),
        value: data['genus'],
      );
}
