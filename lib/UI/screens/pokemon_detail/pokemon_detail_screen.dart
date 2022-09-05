import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_flutter/UI/bloc/pokemon_bloc.dart';
import 'package:pokedex_flutter/UI/screens/pokemon_detail/pokemon_detail_theme.dart';
import 'package:pokedex_flutter/UI/widgets/media/media_container.dart';
import 'package:pokedex_flutter/UI/widgets/type/pokemon_type_container.dart';
import 'package:pokedex_flutter/domain/models/models.dart';
import 'package:pokedex_flutter/utils/extensions/pokemon_type_extension.dart';
import 'package:pokedex_flutter/utils/extensions/string_extension.dart';

class PokemonDetailScreen extends StatefulWidget {
  const PokemonDetailScreen({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final PokemonDetailBloc bloc;

  @override
  _PokemonDetailScreenState createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  PokemonDetailBloc get bloc => widget.bloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Pokemon>(
      stream: bloc.stream,
      initialData: bloc.pokemon,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final pokemon = snapshot.data!;
          return Material(
            child: Stack(
              children: [
                Hero(
                  tag: 'pokemon/${pokemon.id}/type/container}',
                  child: Container(
                    decoration: getBoxDecoration(pokemon.types),
                  ),
                ),
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      pinned: true,
                      // title: Text(pokemon.name!.capitalize()),
                    ),
                    _buildImage(pokemon),
                    _buildContent(pokemon),
                  ],
                ),
              ],
            ),
          );
        }
        return Scaffold();
      },
    );
  }

  BoxDecoration getBoxDecoration(List<PokemonType>? types) {
    Color _degradeColor(Color color) {
      return Color.lerp(color, Colors.grey, 0.4)!.withOpacity(0.6);
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

  Widget _buildImage(Pokemon pokemon) {
    return SliverToBoxAdapter(
      child: Hero(
        tag: 'pokemon/image/${pokemon.id}',
        child: Container(
          margin: EdgeInsets.all(30),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 8,
            ),
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/pokeball.png'),
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.05),
                BlendMode.dstIn,
              ),
              scale: 0.25,
            ),
          ),
          child: CachedNetworkImage(
            imageUrl: pokemon.sprites?.artwork?.frontDefault?.url ?? '',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget _buildContent(Pokemon pokemon) {
    return SliverToBoxAdapter(
      child: Container(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.2),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: 6,
              sigmaX: 6,
            ),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildName(pokemon),
                  _buildDescription(pokemon),
                  _buildMedia(pokemon),
                  SizedBox(height: 200,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildName(Pokemon pokemon) {
    final shortDescription = pokemon.species?.genera?.capitalize();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.1), width: 2),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (pokemon.species?.name ?? pokemon.name)!.capitalize(),
                  style: PokemonDetailTheme.pokemonTitleStyle(context),
                ),
                Visibility(
                  visible: shortDescription?.isNotEmpty == true,
                  child: Text(
                    shortDescription ??'',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: pokemon.types!.map(_buildTypeContainer).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildTypeContainer(PokemonType type) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: PokemonTypeContainer(
        type: type,
        size: 20,
      ),
    );
  }

  Widget _buildDescription(Pokemon pokemon) {
    final description = pokemon.species?.flavorTexts?.first.value;
    return Visibility(
      visible: description?.isNotEmpty == true,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: TextStyle(
                color:
                    Theme.of(context).colorScheme.onSurface,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                height: 1.4,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              description!.formatPokemonDescription(),
              style: TextStyle(
                color:
                    Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w100,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedia(Pokemon pokemon) {
    final sprites = [
      pokemon.sprites?.defaultMedia,
      pokemon.sprites?.dreamWorld,
      pokemon.sprites?.home,
    ]..removeWhere(
        (element) => element == null,
      );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Media',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.75),
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 100,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            children: sprites
                .map((sprite) => buildMediaContainer(sprite?.frontDefault))
                .toList(),
          ),
        )
      ],
    );
  }

  Widget buildMediaContainer(Media? media) {
    return Visibility(
      visible: media?.url != null,
      child: Container(
        margin: EdgeInsets.only(right: 20),
        child: AspectRatio(
          aspectRatio: 1,
          child: MediaContainer(
            media: media!,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
