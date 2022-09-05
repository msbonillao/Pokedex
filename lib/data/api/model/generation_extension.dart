// ignore_for_file: unused_import

import 'package:pokedex_flutter/data/core/api_constants.dart';
import 'package:pokedex_flutter/domain/models/generation/generation.dart';
import 'package:pokedex_flutter/domain/models/generation_content.dart';
import 'package:pokedex_flutter/domain/models/models.dart';
import 'package:pokedex_flutter/utils/functions/base_parsing.dart';

import '../api_parsing.dart';

extension GenerationParsingExtension on Generation {
  static GenerationCollection<Sprite>? fromJson<T>(
    Map<String, dynamic>? data,
    JSONParser parser,
  ) {
    if (data == null) return null;
    return GenerationCollection(
      generationI: _generationIFromJson<T>(
        data[generationIKey],
        parser,
      ),
      generationII: _generationIIFromJson(
        data[generationIIKey],
        parser,
      ),
      generationIII: _generationIIIFromJson(
        data[generationIIIKey],
        parser,
      ),
      generationIV: _generationIVFromJson(
        data[generationIVKey],
        parser,
      ),
      generationV: _generationVFromJson(
        data[generationVKey],
        parser,
      ),
      generationVI: _generationVIFromJson(
        data[generationVIKey],
        parser,
      ),
      generationVII: _generationVIIFromJson(
        data[generationVIIKey],
        parser,
      ),
      generationVIII: _generationVIIIFromJson(
        data[generationVIIIKey],
        parser,
      ),
    );
  }

  static GenerationI<Sprite>? _generationIFromJson<T>(
      Map<String, dynamic>? data, JSONParser parser) {
    if (data == null) return null;
    return GenerationI(
      redBlue: parser(data['red-blue']),
      yellow: parser(data['yellow']),
    );
  }

  static GenerationII<Sprite>? _generationIIFromJson(
      Map<String, dynamic>? data, JSONParser parser) {
    if (data == null) return null;
    return GenerationII(
      gold: parser(data['gold']),
      crystal: parser(data['crystal']),
      silver: parser(data['silver']),
    );
  }

  static GenerationIII<Sprite>? _generationIIIFromJson(
      Map<String, dynamic>? data, JSONParser parser) {
    if (data == null) return null;
    return GenerationIII(
      emerald: parser(data['emerald']),
      fireRedLeafGreen: parser(data['firered-leafgreen']),
      rubySapphire: parser(data['ruby-sapphire']),
    );
  }

  static GenerationIV<Sprite>? _generationIVFromJson(
      Map<String, dynamic>? data, JSONParser parser) {
    if (data == null) return null;
    return GenerationIV(
      diamondPearl: parser(data['diamond-pearl']),
      heartGoldSoulSilver: parser(data['heartgold-soulsilver']),
      platinum: parser(data['platinum']),
    );
  }

  static GenerationV<Sprite>? _generationVFromJson(
      Map<String, dynamic>? data, JSONParser parser) {
    if (data == null) return null;
    return GenerationV(
        blackWhite: parser(
      data['black-white'],
    ));
  }

  static GenerationVI<Sprite>? _generationVIFromJson(
      Map<String, dynamic>? data, JSONParser parser) {
    if (data == null) return null;
    return GenerationVI(
      omegaRuby: parser(
        data['omegaruby-alphasapphire'],
      ),
      xy: parser(data['x-y']),
    );
  }

  static GenerationVII<Sprite>? _generationVIIFromJson(
      Map<String, dynamic>? data, JSONParser parser) {
    if (data == null) return null;
    return GenerationVII(parser(data['ultra-sun-ultra-moon']));
  }

  static GenerationVIII<Sprite>? _generationVIIIFromJson(
      Map<String, dynamic>? data, JSONParser parser) {
    if (data == null) return null;
    return GenerationVIII(parser(data['icons']));
  }
}
