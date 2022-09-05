import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:pokedex_flutter/domain/models/models.dart';
import 'package:pokedex_flutter/domain/use_cases/interfaces/pokemon_detail_use_case.dart';
import 'interface/i_pokemon_detail_bloc.dart';

class PokemonDetailBloc implements IPokemonDetailBloc {
  PokemonDetailBloc({
    required this.useCase,
    required this.id,
  });

  final PokemonDetailUseCase useCase;
  final Object id;
  final _controller = StreamController<Pokemon>.broadcast();

  Stream<Pokemon> get stream => _controller.stream;

  Pokemon? pokemon;

  @override
  Future<void> dispose() async {
    _controller.close();
  }

  @override
  Future<void> initialize() async {
    try {
      pokemon = await useCase.getPokemon(id);
      _controller.add(pokemon!);
      final species = await useCase.getPokemonSpecies(id);
      pokemon = pokemon?.copyWith(species: species);
      _controller.add(pokemon!);
    } on Exception catch (e) {
      FlutterError.onError?.call(FlutterErrorDetails(
        exception: e,
      ));
      _controller.addError(e);
    }
  }
}
