import 'generation.dart';

class GenerationII<T> extends Generation<T> {
  final T crystal;
  final T gold;
  final T silver;

  GenerationII({
    required this.crystal,
    required this.gold,
    required this.silver,
  });
}
