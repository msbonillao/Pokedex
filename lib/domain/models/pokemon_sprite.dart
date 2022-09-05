import 'package:flutter/foundation.dart';
import 'package:pokedex_flutter/domain/models/generation_content.dart';
import 'models.dart';

@immutable
class PokemonSprites {
  final Sprite? defaultMedia;
  final Sprite? dreamWorld;
  final Sprite? home;
  final Sprite? artwork;
  final GenerationCollection<Sprite>? generationSprite;

  const PokemonSprites({
    required this.defaultMedia,
    required this.dreamWorld,
    required this.home,
    required this.artwork,
    required this.generationSprite,
  });

}
