import 'dart:async';

import 'package:pokedex_flutter/domain/models/pokedex.dart';

import 'interface/i_pokemon_list_bloc.dart';
import '../../domain/use_cases/interfaces/pokemon_list_use_case.dart';

class PokemonScreenBloc implements IPokemonListBloc {
  final PokemonListUseCase useCase;

  PokemonScreenBloc({
    required this.useCase,
  });

  Pokedex? pokedex;

  final _streamController = StreamController<Pokedex>.broadcast();

  Stream<Pokedex> get stream => _streamController.stream;

  @override
  Future<void> dispose() async {
    _streamController.close();
  }

  @override
  Future<void> initialize() async {
    try {
      pokedex = await useCase.getPokedex(1);
      _streamController.add(pokedex!);
    } catch (e) {
      _streamController.addError(e);
    }
  }
}
