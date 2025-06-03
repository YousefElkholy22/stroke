import 'package:fpdart/fpdart.dart';
import 'package:mohammed_ashraf/core/errors/failure.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams {}
