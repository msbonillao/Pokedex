import 'media/media.dart';

class Sprite {
  final Media? backDefault;
  final Media? backFemale;
  final Media? backShiny;
  final Media? backShinyFemale;
  final Media? frontDefault;
  final Media? frontFemale;
  final Media? frontShiny;
  final Media? frontShinyFemale;

  Sprite({
    required this.backDefault,
    required this.backFemale,
    required this.backShiny,
    required this.backShinyFemale,
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    required this.frontShinyFemale,
  });

  List<Media?> get all => [
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
