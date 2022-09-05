import 'package:pokedex_flutter/data/api/model/language.dart';

abstract class LanguageResource<T> {
  ApiLanguage get language;

  T get value;
}
