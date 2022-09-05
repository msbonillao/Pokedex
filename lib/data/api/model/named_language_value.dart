import 'package:pokedex_flutter/data/api/model/language.dart';
import 'package:pokedex_flutter/data/api/model/language_resource.dart';

class NamedLanguageValue implements LanguageResource<String> {
  @override
  final ApiLanguage language;

  @override
  final String value;

  NamedLanguageValue({
    required this.language,
    required this.value,
  });

  factory NamedLanguageValue.fromJson(Map<String, dynamic> map, String key) =>
      NamedLanguageValue(
        language: ApiLanguage.fromJson(map['language']),
        value: map[key],
      );
}
