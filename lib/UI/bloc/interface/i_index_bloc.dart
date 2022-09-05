import 'bloc.dart';

abstract class ApplicationBloc implements Bloc {
  Stream<bool> get stream;

  bool get state;
}
