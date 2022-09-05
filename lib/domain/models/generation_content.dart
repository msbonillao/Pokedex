import 'generation/generation.dart';

class GenerationCollection<T> {
  final Generation<T?>? generationI;
  final Generation<T?>? generationII;
  final Generation<T?>? generationIII;
  final Generation<T?>? generationIV;
  final Generation<T?>? generationV;
  final Generation<T?>? generationVI;
  final Generation<T?>? generationVII;
  final Generation<T?> ?generationVIII;

  const GenerationCollection({
    required this.generationI,
    required this.generationII,
    required this.generationIII,
    required this.generationIV,
    required this.generationV,
    required this.generationVI,
    required this.generationVII,
    required this.generationVIII,
  });
}
