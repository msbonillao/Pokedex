import 'package:pokedex_flutter/data/api/model/language_resource.dart';

import 'language.dart';

class PokemonName extends LanguageResource<String> {
  final ApiLanguage language;
  final String name;

  PokemonName({
    required this.language,
    required this.name,
  });

  factory PokemonName.fromJson(Map<String, dynamic> data) => PokemonName(
        language: ApiLanguage.fromJson(data['language']),
        name: data['name'],
      );

  @override
  String get value => name;
}

extension LanguageFiltering on List<LanguageResource> {
  String get value {
    return firstWhere((element) => element.language.id == 'en').value;
  }
}
