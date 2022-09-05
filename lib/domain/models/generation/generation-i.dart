import 'generation.dart';

class GenerationI<T> extends Generation<T> {
  final T? redBlue;
  final T? yellow;

  GenerationI({
    required this.redBlue,
    required this.yellow,
  });
}
