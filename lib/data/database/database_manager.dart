import 'package:pokedex_flutter/UI/bloc/interface/bloc.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class DatabaseManager implements Bloc {
  final _dbPath = 'pokemon.db';
  DatabaseFactory dbFactory = databaseFactoryIo;
  late Database db;

  @override
  Future<void> dispose() async {
    db.close();
  }

  @override
  Future<void> initialize() async {
    var dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    var dbPath = join(dir.path, _dbPath);
    db = await databaseFactoryIo.openDatabase(dbPath);
  }
}
