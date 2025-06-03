import 'package:fpdart/fpdart.dart';
import 'package:mohammed_ashraf/core/errors/failure.dart';
import 'package:mohammed_ashraf/core/usecase/use_case.dart';
import 'package:mohammed_ashraf/features/auth/data/models/user_response.dart';
import 'package:mohammed_ashraf/features/auth/domain/repositories/auth_repo.dart';

class RegisterUseCase extends UseCase<UserResponse, RegisterParams> {
  final AuthRepo authRepo;
  RegisterUseCase({required this.authRepo});

  @override
  Future<Either<Failure, UserResponse>> call(RegisterParams params) {
    return authRepo.register(registerParams: params, userType: params.userType);
  }
}
