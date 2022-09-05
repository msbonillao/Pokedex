import 'package:pokedex_flutter/domain/models/version.dart';

class VersionableValue<T> {
  const VersionableValue({required this.value, required this.version});

  final T value;

  final PokemonVersion version;
}
