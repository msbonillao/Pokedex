import 'package:flutter/material.dart';
import 'package:pokedex_flutter/UI/bloc/pokemon_bloc.dart';
import 'package:pokedex_flutter/UI/screens/pokemon_detail/pokemon_detail_screen.dart';
import 'package:pokedex_flutter/UI/widgets/type/pokemon_type_container.dart';
import 'package:pokedex_flutter/application/dependency_injection.dart';
import 'package:pokedex_flutter/domain/models/pokemon.dart';
import 'package:pokedex_flutter/domain/models/pokemon_type.dart';
import 'package:pokedex_flutter/utils/extensions/string_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokedex_flutter/utils/extensions/pokemon_type_extension.dart';

class PokemonCard extends StatefulWidget {
  PokemonCard({
    Key? key,
    required String pokemonID,
  })  : _bloc = DependencyInjector().getPokemonBloc(pokemonID),
        super(key: key);

  final PokemonDetailBloc _bloc;

  @override
  State<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: _onCardTapped,
        child: StreamBuilder<Pokemon>(
          stream: widget._bloc.stream,
          initialData: widget._bloc.pokemon,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final pokemon = snapshot.data!;
              return buildCard(pokemon);
            }
            return buildLoading();
          },
        ),
      ),
    );
  }

  Widget buildCard(Pokemon pokemon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              Hero(
                tag: 'pokemon/${pokemon.id}/type/container',
                child: Container(
                  decoration: getBoxDecoration(pokemon.types),
                ),
              ),
              Hero(
                tag: 'pokemon/image/${pokemon.id}',
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/pokeball.png'),
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.03),
                        BlendMode.dstIn,
                      ),
                      scale: 0.2,
                    ),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: pokemon.sprites?.artwork?.frontDefault?.url ?? '',
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Container(
            constraints: BoxConstraints(minHeight: kMinInteractiveDimension),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: 'pokemon/label/${pokemon.id}',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              (pokemon.species?.name ?? pokemon.name)
                                  .toString()
                                  .capitalize(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Text(
                          pokemon.species?.genera ?? '',
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.8),
                            fontWeight: FontWeight.w300,
                            fontSize: 11,
                            height: 1.4,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 2,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:
                        pokemon.types?.map(buildTypeContainer).toList() ?? [],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildLoading() {
    return Column();
  }

  BoxDecoration getBoxDecoration(List<PokemonType>? types) {
    Color _degradeColor(Color color) {
      return Color.lerp(color, Colors.grey, 0.2)!.withOpacity(0.8);
    }

    types ??= [];
    if (types.length == 2) {
      final colors = types.map((e) {
        return _degradeColor(e.color);
      }).toList();
      return BoxDecoration(
        gradient: LinearGradient(colors: colors),
      );
    }
    Color? color;
    if (types.isNotEmpty) color = _degradeColor(types.first.color);
    return BoxDecoration(color: color);
  }

  Widget buildTypeContainer(PokemonType type) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1),
      child: PokemonTypeContainer(type: type),
    );
  }

  void _onCardTapped() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return PokemonDetailScreen(bloc: widget._bloc);
      }),
    );
  }
}
