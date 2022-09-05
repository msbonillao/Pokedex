import 'package:pokedex_flutter/domain/models/models.dart';

extension CollectionAPIParsing on Collection {
  static Collection<T> fromJson<T>(Map<String, dynamic> data) {
    return Collection(name: data['name'], url: data['url']);
  }
}
