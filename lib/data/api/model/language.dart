import 'package:pokedex_flutter/domain/models/api_resource.dart';

class ApiLanguage implements APIResource {
  const ApiLanguage(this.id);

  final String id;

  @override
  final String resource = 'language';

  factory ApiLanguage.fromJson(Map<String, dynamic> data) =>
      ApiLanguage(data['name']);
}
