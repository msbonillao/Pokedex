import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_flutter/data/api/api_parsing.dart';
import 'package:pokedex_flutter/domain/models/models.dart';

import 'data/pokemon_data.dart';

void main() {
  test('Parsing Pokemon from Mocked Data', () {
    final pokemon = APIParsing.pokemonFromJson(charmander);
    expect(pokemon, isInstanceOf<Pokemon>());
  });
}
