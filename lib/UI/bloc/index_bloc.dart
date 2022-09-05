import 'dart:async';

import 'package:pokedex_flutter/UI/bloc/interface/i_index_bloc.dart';
import 'package:pokedex_flutter/domain/use_cases/interfaces/pokemon_index_use_case.dart';

class ApplicationIndexBloc implements ApplicationBloc {
  final PokemonIndexUseCase useCase;

  ApplicationIndexBloc({required this.useCase});

  final _controller = StreamController<bool>.broadcast();

  Stream<bool> get stream => _controller.stream;
  bool state = false;

  @override
  Future<void> dispose() async {
    _controller.close();
  }

  @override
  Future<void> initialize() async {
    final index = await useCase.fetchIndex();
    final count = await useCase.countCurrentIndex();
    if (count != index.pokemonEntries.length)
      await useCase.createIndex(index.pokemonEntries);
    state = true;
    _controller.add(state);
  }
}
