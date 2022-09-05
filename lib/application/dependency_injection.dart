import 'package:pokedex_flutter/UI/bloc/index_bloc.dart';
import 'package:pokedex_flutter/UI/bloc/interface/i_index_bloc.dart';
import 'package:pokedex_flutter/UI/bloc/interface/i_pokemon_list_bloc.dart';
import 'package:pokedex_flutter/UI/bloc/pokemon_bloc.dart';
import 'package:pokedex_flutter/UI/bloc/pokemon_list_screen_bloc.dart';
import 'package:pokedex_flutter/application/application.dart';
import 'package:pokedex_flutter/data/api/pokedex/pokedex_network_impl.dart';
import 'package:pokedex_flutter/data/api/pokemon/i_pokemon_network_source.dart';
import 'package:pokedex_flutter/data/api/pokemon/pokemon_network_source.dart';
import 'package:pokedex_flutter/data/database/database_manager.dart';
import 'package:pokedex_flutter/data/database/index/index_database.dart';
import 'package:pokedex_flutter/data/database/pokedex/pokedex_database_impl.dart';
import 'package:pokedex_flutter/data/database/pokemon/i_pokemon_database.dart';
import 'package:pokedex_flutter/data/database/pokemon/pokemon_database.dart';
import 'package:pokedex_flutter/data/repositories/pokedex/i_pokedex_repository.dart';
import 'package:pokedex_flutter/data/repositories/pokedex/pokedex_repository.dart';
import 'package:pokedex_flutter/data/repositories/pokemon/i_pokemon_repository.dart';
import 'package:pokedex_flutter/data/repositories/pokemon/pokemon_repository.dart';
import 'package:pokedex_flutter/domain/use_cases/index_use_case_implementation.dart';
import 'package:pokedex_flutter/domain/use_cases/pokemon_detail_use_case_impl.dart';
import 'package:pokedex_flutter/domain/use_cases/pokemon_list_use_case_impl.dart';

class DependencyInjector {
  static final DependencyInjector _instance = DependencyInjector._();

  DependencyInjector._();

  factory DependencyInjector() => _instance;

  final _applicationModule = ApplicationModule();

  final _dependencies = <Object, Object>{};

  final DatabaseManager databaseManager = DatabaseManager();

  PokemonDatabase get _pokemonDatabase =>
      _dependencies[PokemonDatabase] as PokemonDatabase? ??
      _buildPokemonDatabase();

  PokedexRepository get _pokedexRepository =>
      _dependencies[PokedexRepository] as PokedexRepository? ??
      _buildPokedexRepository();

  IPokemonListBloc get pokemonListBloc => PokemonScreenBloc(
        useCase: PokemonListUseCaseImpl(
          repository: _pokedexRepository,
        ),
      );

  PokemonNetworkSource getPokemonNetworkSource() =>
      _dependencies[PokemonNetworkSource] as PokemonNetworkSource? ??
      _buildPokemonNetworkSource();

  PokemonRepository getPokemonRepository() =>
      _dependencies[PokemonRepository] as PokemonRepository? ??
      _buildPokemonRepository();

  PokemonDetailBloc getPokemonBloc(String id) =>
      _dependencies['$PokemonDetailBloc/$id'] as PokemonDetailBloc? ??
      _buildPokemonBloc(id);

  PokemonRepository _buildPokemonRepository() {
    final repository = PokemonRepositoryImpl(
        networkSource: getPokemonNetworkSource(),
        localSource: _pokemonDatabase);
    _registerDependency(PokemonRepository, repository);
    return repository;
  }

  PokemonNetworkSource _buildPokemonNetworkSource() {
    final dependency = PokemonNetworkSourceImpl(
      client: _applicationModule.httpClient,
    );
    _registerDependency(PokemonNetworkSource, dependency);
    return dependency;
  }

  void _registerDependency(Object key, Object dependency) {
    _dependencies[key] = dependency;
  }

  PokemonDetailBloc _buildPokemonBloc(String id) {
    final dependency = PokemonDetailBloc(
        useCase: PokemonDetailUseCaseImpl(
          repository: getPokemonRepository(),
        ),
        id: id)
      ..initialize();
    return dependency;
  }

  PokemonDatabase _buildPokemonDatabase() {
    final dependency = PokemonDatabaseImpl(
      db: databaseManager,
    );
    _registerDependency('$PokemonDatabase', dependency);
    return dependency;
  }

  PokedexRepository _buildPokedexRepository() {
    final dependency = PokedexRepositoryImpl(
      remote: PokedexNetworkSourceImpl(_applicationModule.httpClient),
      local: PokedexDatabaseImpl(databaseManager),
    );
    _registerDependency(PokedexRepository, dependency);
    return dependency;
  }

  ApplicationBloc get applicationBloc =>
      _dependencies[ApplicationBloc] as ApplicationBloc? ?? _buildAppBloc();

  ApplicationBloc _buildAppBloc() {
    final dependency = ApplicationIndexBloc(
      useCase:IndexUseCaseImpl(pokedexRepository: _pokedexRepository, indexRepository: IndexDatabase(databaseManager))
    );
    _registerDependency(ApplicationBloc, dependency);
    return dependency;
  }
}
