import '../../../domain/models/pokedex.dart';

abstract class PokedexNetworkSource {
  Future<Pokedex> fetchPokedex(Object id);
}
