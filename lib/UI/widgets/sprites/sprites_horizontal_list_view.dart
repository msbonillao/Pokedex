import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_flutter/UI/widgets/sprites/sprite_color_map.dart';
import 'package:pokedex_flutter/utils/constants/styles/colors.dart';

import '../../../domain/models/generation/generation.dart';
import '../../../domain/models/models.dart';

class PokemonSpritesListView extends StatefulWidget {
  const PokemonSpritesListView({
    Key? key,
    required this.pokemon,
  }) : super(key: key);
  final Pokemon pokemon;

  @override
  State<PokemonSpritesListView> createState() => _PokemonSpritesListViewState();
}

class _PokemonSpritesListViewState extends State<PokemonSpritesListView> {
  List<Generation<Sprite?>?> get actualSprites {
    final generations = widget.pokemon.sprites?.generationSprite;
    final result = [
      generations?.generationI,
      generations?.generationII,
      generations?.generationIII,
      generations?.generationIV,
      generations?.generationV,
      generations?.generationVI,
      generations?.generationVII,
      generations?.generationVII,
      generations?.generationVIII,
    ];
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final sprites = actualSprites..removeWhere((element) => element == null);
    return Container(
      height: 150,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: sprites.length,
        itemBuilder: (context, index) {
          final sprite = sprites[index];
          return _buildGenerationSprite(sprite);
        },
        separatorBuilder: (context, index) => SizedBox(
          width: 16,
        ),
      ),
    );
  }

  Widget _buildGenerationSprite(Generation<Sprite?>? sprite) {
    return Visibility(
      visible: sprite != null,
      child: _buildSpriteCard(sprite!),
    );
  }

  Widget _buildSpriteCard(Generation<Sprite?> generation) {
    final defaultSprite = getDefaultSprite(generation);
    if (defaultSprite != null &&  defaultSprite.media?.url !=null )
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        color: Theme.of(context).colorScheme.surface.withOpacity(0.4),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.white.withOpacity(0.8),
                child: CachedNetworkImage(
                  color: Colors.transparent,
                  colorBlendMode: BlendMode.dstOut,
                  imageUrl: defaultSprite.media!.url!,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(4),
              padding: EdgeInsets.all(6),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: defaultSprite.color,
                shape: BoxShape.circle,
              ),
              child: Text(
                defaultSprite.label,
                style: TextStyle(color: Colors.white.withOpacity(0.8)),
              ),
            )
          ],
        ),
      );
    return Container();
  }

  _SpriteData? getDefaultSprite(Generation<Sprite?> generation) {
    if (generation is GenerationI<Sprite>) {
      return _SpriteData(
        media: generation.yellow?.frontDefault,
        color: generationIColor,
        label: generationTypeLabel[GenerationI]!,
      );
    }
    if (generation is GenerationII<Sprite>) {
      return _SpriteData(
        media: generation.gold.frontDefault,
        color: generationIIColor,
        label: generationTypeLabel[GenerationII]!,
      );
    }
    if (generation is GenerationIII<Sprite>) {
      return _SpriteData(
        media: generation.rubySapphire.frontDefault,
        color: generationIIIColor,
        label: generationTypeLabel[GenerationIII]!,
      );
    }
    if (generation is GenerationIV<Sprite>) {
      return _SpriteData(
        media: generation.diamondPearl.frontDefault,
        color: generationIVColor,
        label: generationTypeLabel[GenerationIV]!,
      );
    }
    if (generation is GenerationV<Sprite>) {
      return _SpriteData(
        media: generation.blackWhite.frontDefault,
        color: generationVColor,
        label: generationTypeLabel[GenerationV]!,
      );
    }
    if (generation is GenerationVII<Sprite>) {
      return _SpriteData(
        media: generation.icons.frontDefault,
        color: generationVIColor,
        label: generationTypeLabel[GenerationVII]!,
      );
    }
    if (generation is GenerationVIII<Sprite>) {
      return _SpriteData(
        media: generation.icons.frontDefault,
        color: generationVIIIColor,
        label: generationTypeLabel[GenerationVIII]!,
      );
    }
    return null;
  }
}

class _SpriteData {
  final Color? color;
  final String label;
  final Media? media;

  _SpriteData({
    required this.color,
    required this.label,
    required this.media,
  });
}
