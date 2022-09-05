import '../../../domain/models/pokemon.dart';

import 'bloc.dart';

abstract class IPokemonDetailBloc implements Bloc {
  Pokemon? get pokemon;

  Stream<Pokemon> get stream;
}
