import 'package:flutter/foundation.dart';

typedef JSONParser<T> = T Function(Map<String, dynamic>);

abstract class BaseParsing {
  static List<T> parseList<T>({
    required List<dynamic>? data,
    required JSONParser<T> parser,
    bool catchParsingErrors = true,
  }) {
    final list = <T>[];
    data?.forEach((element) {
      try {
        final object = parser.call(element);
        list.add(object);
      } catch (e) {
        if (!catchParsingErrors) rethrow;
        debugPrint('Error Parsing from List for type: $T');
        FlutterError.onError?.call(
          FlutterErrorDetails(exception: e),
        );
      }
    });
    return list;
  }
}
