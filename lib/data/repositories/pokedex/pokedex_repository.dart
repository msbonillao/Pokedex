import '../../api/pokedex/i_pokedex_network_source.dart';
import '../../database/pokedex/pokedex_database.dart';
import 'i_pokedex_repository.dart';
import '../../../domain/models/pokedex.dart';

class PokedexRepositoryImpl implements PokedexRepository {
  final PokedexNetworkSource remote;
  final PokedexDatabase local;

  PokedexRepositoryImpl({
    required this.remote,
    required this.local,
  });

  @override
  Future<Pokedex> fetchPokedex(Object id) async {
    Pokedex? pokedex = await local.fetchPokedexById(id);
    if (pokedex == null) {
      pokedex = await remote.fetchPokedex(id);
      local.savePokedex(pokedex);
    }
    return pokedex;
  }
}
