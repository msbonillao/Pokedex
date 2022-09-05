import 'package:pokedex_flutter/domain/errors/error.dart';

class ServerError implements AppError {
  const ServerError([this.message]);

  final String? message;
}
