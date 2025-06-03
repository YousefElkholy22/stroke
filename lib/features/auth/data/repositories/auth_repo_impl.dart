import 'package:fpdart/src/either.dart';
import 'package:mohammed_ashraf/core/enums/user_type.dart';
import 'package:mohammed_ashraf/core/errors/exception.dart';
import 'package:mohammed_ashraf/core/errors/failure.dart';
import 'package:mohammed_ashraf/core/respomse/basic_response.dart';
import 'package:mohammed_ashraf/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:mohammed_ashraf/features/auth/data/datasources/auth_remote_data_sourcec.dart';
import 'package:mohammed_ashraf/features/auth/data/models/user_response.dart';
import 'package:mohammed_ashraf/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  AuthRepoImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });
  @override
  Future<Either<Failure, UserResponse>> login(
      {required String email, required String password}) async {
    try {
      final data =
          await authRemoteDataSource.login(email: email, password: password);
      return right(data);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }

  @override
  Future<Either<Failure, UserResponse>> register({
    required RegisterParams registerParams,
    required UserType userType,
  }) async {
    try {
      final data = await authRemoteDataSource.register(
          params: registerParams, userType: userType);
      return right(data);
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }

  @override
  Future<Either<Failure, BasicResponse>> forgetPassword(
      {required String email}) {
    // TODO: implement forgetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, BasicResponse>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, BasicResponse>> resetPassword(
      {required String password, required String confirmPassword}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, BasicResponse>> verifyOtp({required String otp}) {
    // TODO: implement verifyOtp
    throw UnimplementedError();
  }
}
