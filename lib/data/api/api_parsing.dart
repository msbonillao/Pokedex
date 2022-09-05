// ignore_for_file: unused_element

import 'package:pokedex_flutter/data/api/model/genera.dart';
import 'package:pokedex_flutter/data/api/model/generation_extension.dart';
import 'package:pokedex_flutter/data/api/model/named_language_value.dart';
import 'package:pokedex_flutter/data/api/model/pokemon_name.dart';
import 'package:pokedex_flutter/data/api/parse_function.dart';
import 'package:pokedex_flutter/domain/models/api_resource.dart';
import 'package:pokedex_flutter/domain/models/flavor_text.dart';
import 'package:pokedex_flutter/domain/models/generations/generation_sprite.dart';
import 'package:pokedex_flutter/domain/models/models.dart';
import 'package:pokedex_flutter/domain/models/media/image_media.dart';
import 'package:pokedex_flutter/domain/models/pokedex.dart';
import 'package:pokedex_flutter/domain/models/pokemon_entry.dart';
import 'package:pokedex_flutter/domain/models/pokemon_species.dart';
import 'package:pokedex_flutter/domain/models/pokemon_sprite.dart';
import 'package:pokedex_flutter/domain/models/version.dart';
import 'package:pokedex_flutter/utils/functions/base_parsing.dart';

abstract class APIParsing {
  static APIResource apiResourceFromJson(Map<String, dynamic> data) {
    return APIResource.fromUrl(data['url']);
  }

  static Pokemon pokemonFromJson(Map<String, dynamic> data) {
    return Pokemon(
      id: data['id'],
      name: data['name'],
      types: BaseParsing.parseList(
        data: data['types'],
        parser: pokemonTypeFromJson,
      ),
      sprites: spritesFromJson(data['sprites']),
    );
  }

  static PokemonType pokemonTypeFromJson(Map<String, dynamic> data) {
    return PokemonType(
      label: data['type']!['name'],
      id: data['type']!['name'],
    );
  }

  static PokemonSprites spritesFromJson(Map<String, dynamic>? data) {
    return PokemonSprites(
      defaultMedia: spriteFromJson(data),
      dreamWorld: spriteFromJson(data?['other']?['dream_world']),
      home: spriteFromJson(data?['other']?['home']),
      artwork: spriteFromJson(data?['other']?['official-artwork']),
      generationSprite: GenerationParsingExtension.fromJson(
        data?['versions'],
        spriteFromJson,
      ),
    );
  }

  static Sprite spriteFromJson(Map<String, dynamic>? data) {
    return Sprite(
      frontDefault: ImageMedia(data?['front_default']),
      frontShiny: ImageMedia(data?['front_shiny']),
      frontFemale: ImageMedia(data?['front_female']),
      frontShinyFemale: ImageMedia(data?['back_shiny_female']),
      backDefault: ImageMedia(data?['back_default']),
      backFemale: ImageMedia(data?['back_female']),
      backShiny: ImageMedia(data?['back_shiny']),
      backShinyFemale: ImageMedia(data?['back_shiny_female']),
    );
  }

  static PokemonSpecies speciesFromJson(Map<String, dynamic> data) {
    return PokemonSpecies(
      baseHappiness: tryParseInt(data['base_happiness']),
      captureRate: tryParseInt(data['capture_rate']),
      flavorTexts: BaseParsing.parseList(
        data: data['flavor_text_entries'],
        parser: flavorTextFormJson,
      ),
      name: BaseParsing.parseList<PokemonName>(
        data: data['names'],
        parser: (data) => PokemonName.fromJson(data),
      ).value,
      genera: BaseParsing.parseList<PokemonGenera>(
        data: data['genera'],
        parser: (data) => PokemonGenera.fromJson(data),
      ).value,
    );
  }

  static VersionableValue<String> flavorTextFormJson(
      Map<String, dynamic> data) {
    return VersionableValue(
      value: data['flavor_text'],
      version: versionFromJson(data['version']),
    );
  }

  static PokemonVersion versionFromJson(Map<String, dynamic> data) =>
      PokemonVersion(
        APIResource.fromUrl(data['url']).id,
      );

  static GenerationSprite _generationSpriteFromJson(
      Map<String, dynamic>? data) {
    return GenerationSprite(
      animated: spriteFromJson(data?['animated']),
      frontDefault: ImageMedia(data?['front_default']),
      frontShiny: ImageMedia(data?['front_shiny']),
      frontFemale: ImageMedia(data?['front_female']),
      frontShinyFemale: ImageMedia(data?['back_shiny_female']),
      backDefault: ImageMedia(data?['back_default']),
      backFemale: ImageMedia(data?['back_female']),
      backShiny: ImageMedia(data?['back_shiny']),
      backShinyFemale: ImageMedia(data?['back_shiny_female']),
    );
  }

  static Pokedex pokedexFromJson(Map<String, dynamic> map) {
    return Pokedex(
      id: map['id'],
      description: BaseParsing.parseList(
        data: map['descriptions'],
        parser: (data) => NamedLanguageValue.fromJson(data, 'description'),
      ).value,
      name: BaseParsing.parseList(
        data: map['names'],
        parser: (data) => NamedLanguageValue.fromJson(data, 'name'),
      ).value,
      pokemonEntries: BaseParsing.parseList(
        data: map['pokemon_entries'],
        parser: pokemonEntryFromPokedexJson,
      ),
    );
  }

  static PokemonEntry pokemonEntryFromPokedexJson(Map<String, dynamic> map) {
    return PokemonEntry(
      id: map['entry_number'].toString(),
      resource: map['pokemon_species']?['url'],
      name: map['pokemon_species']?['name'],
    );
  }
}
