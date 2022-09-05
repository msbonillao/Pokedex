import 'package:flutter/material.dart';
import 'package:pokedex_flutter/UI/bloc/pokemon_bloc.dart';
import 'package:pokedex_flutter/UI/screens/pokemon_detail/pokemon_detail_screen.dart';
import 'package:pokedex_flutter/UI/widgets/media/media_container.dart';
import 'package:pokedex_flutter/UI/widgets/type/pokemon_type_container.dart';
import 'package:pokedex_flutter/domain/models/pokemon.dart';

class PokemonTile extends StatelessWidget {
  const PokemonTile({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final PokemonDetailBloc bloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Pokemon>(
      initialData: bloc.pokemon,
      stream: bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final pokemon = snapshot.data!;
          return ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return PokemonDetailScreen(bloc: bloc);
                }),
              );
            },
            leading: AspectRatio(
              aspectRatio: 1,
              child: MediaContainer(
                media: pokemon.sprites?.defaultMedia?.frontDefault,
              ),
            ),
            title: Text(pokemon.species?.name ?? ''),
            subtitle: Text(pokemon.species?.genera ?? ''),
            trailing: Container(
              width: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: pokemon.types
                        ?.map((e) => PokemonTypeContainer(
                              type: e,
                            ),)
                        .toList() ??
                    [],
              ),
            ),
          );
        }
        return ListTile();
      },
    );
  }

  void onPressed() {}
}
