import 'dart:ui';

import 'package:pokedex_flutter/domain/models/generation/generation.dart';
import 'package:pokedex_flutter/utils/constants/styles/colors.dart';

Map<Type, Color> generationTypeColor = {
  GenerationI: generationIColor,
  GenerationII: generationIIColor,
  GenerationIII: generationIIIColor,
  GenerationIV: generationIVColor,
  GenerationV: generationVColor,
  GenerationVI: generationVIColor,
  GenerationVII: generationVIIColor,
  GenerationVIII: generationVIIIColor,
};

Map<Type, String> generationTypeLabel = {
  GenerationI: 'I',
  GenerationII: 'II',
  GenerationIII: 'III',
  GenerationIV: 'IV',
  GenerationV: 'V',
  GenerationVI: 'VI',
  GenerationVII: 'VII',
  GenerationVIII: 'VIII',
};
