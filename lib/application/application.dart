import 'package:dio/dio.dart';

class ApplicationModule {
  static final ApplicationModule _instance = ApplicationModule._();

  ApplicationModule._();

  factory ApplicationModule() => _instance;

  static const BASE_URL = 'https://www.pokeapi.co/api/v2';

  final httpClient = Dio(BaseOptions(baseUrl: BASE_URL));
}
