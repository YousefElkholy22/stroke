import 'package:fpdart/fpdart.dart';
import 'package:mohammed_ashraf/core/errors/failure.dart';
import 'package:mohammed_ashraf/core/usecase/use_case.dart';
import 'package:mohammed_ashraf/features/auth/data/models/user_response.dart';
import 'package:mohammed_ashraf/features/auth/domain/repositories/auth_repo.dart';

class LoginUseCase extends UseCase<UserResponse, LoginParams> {
  final AuthRepo authRepo;
  LoginUseCase({required this.authRepo});

  @override
  Future<Either<Failure, UserResponse>> call(LoginParams params) {
    return authRepo.login(email: params.email, password: params.password);
  }
}
