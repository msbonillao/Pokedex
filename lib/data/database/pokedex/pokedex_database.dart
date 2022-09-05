import '../../../domain/models/pokedex.dart';

abstract class PokedexDatabase {
  void clearCache();

  Future<Pokedex?> fetchPokedexById(Object id);

  void savePokedex(Pokedex pokedex);
}
