import 'package:fpdart/fpdart.dart';
import 'package:mohammed_ashraf/core/enums/user_type.dart';
import 'package:mohammed_ashraf/core/respomse/basic_response.dart';
import 'package:mohammed_ashraf/core/utils/api_base_helper.dart';
import 'package:mohammed_ashraf/features/auth/data/models/user_response.dart';
import 'package:mohammed_ashraf/features/auth/domain/repositories/auth_repo.dart';

String loginEndPoint = "auth/login/";
String registerEndPoint = "auth/register/";
String forgetPasswordEndPoint = "auth/forgot-password/";
String resetPasswordEndPoint = "auth/reset-password/";
String verifyOtpEndPoint = "auth/verify-otp/";
String logoutEndPoint = "auth/logout/";

abstract class AuthRemoteDataSource {
  Future<UserResponse> login({required String email, required String password});
  Future<BasicResponse> forgetPassword({required String email});
  Future<Unit> resetPassword(
      {required String password, required String confirmPassword});
  Future<BasicResponse> verifyOtp({required String otp});
  Future<BasicResponse> logout();
  Future<UserResponse> register({
    required UserType userType,
    required RegisterParams params,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiBaseHelper apiBaseHelper;
  AuthRemoteDataSourceImpl({required this.apiBaseHelper});
  @override
  Future<UserResponse> login(
      {required String email, required String password}) async {
    try {
      final dynamic response = await apiBaseHelper.post(
        url: loginEndPoint,
        body: {"email": email, "password": password},
      );
      return UserResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserResponse> register({
    required UserType userType,
    required RegisterParams params,
  }) async {
    final registerEndPoint =
        userType == UserType.doctor ? 'doctors/register' : 'patients/register';
    try {
      final dynamic response = await apiBaseHelper.post(
        url: registerEndPoint,
        body: params.toJson(),
      );
      return UserResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BasicResponse> forgetPassword({required String email}) async {
    try {
      final dynamic response = await apiBaseHelper.post(
        url: forgetPasswordEndPoint,
        body: {"email": email},
      );
      return BasicResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BasicResponse> logout() async {
    try {
      final dynamic response = await apiBaseHelper.get(
        url: logoutEndPoint,
      );
      return BasicResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> resetPassword(
      {required String password, required String confirmPassword}) async {
    try {
      await apiBaseHelper.post(
        url: forgetPasswordEndPoint,
        body: {"password": password, "confirm_password": confirmPassword},
      );
      return unit;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BasicResponse> verifyOtp({required String otp}) async {
    try {
      final dynamic response = await apiBaseHelper.post(
        url: forgetPasswordEndPoint,
        body: {"otp": otp},
      );
      return BasicResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
