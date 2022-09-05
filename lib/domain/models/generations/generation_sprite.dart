import 'package:pokedex_flutter/domain/models/media/media.dart';

import '../sprite.dart';

class GenerationSprite implements Sprite {
  final Sprite? animated;

  final Media? backDefault;

  final Media? backFemale;

  final Media? backShiny;

  final Media? backShinyFemale;

  final Media? frontDefault;

  final Media? frontFemale;

  final Media? frontShiny;

  final Media? frontShinyFemale;

  GenerationSprite({
    required this.animated,
    required this.backDefault,
    required this.backFemale,
    required this.backShiny,
    required this.backShinyFemale,
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    required this.frontShinyFemale,
  });

  @override
  List<Media?> get all => [
        ...animated?.all ?? [],
        frontDefault,
        backDefault,
        frontFemale,
        backFemale,
        frontShiny,
        backShiny,
        frontShinyFemale,
        backShinyFemale,
      ];
}
