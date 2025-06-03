import 'package:fpdart/fpdart.dart';
import 'package:mohammed_ashraf/core/enums/user_type.dart';
import 'package:mohammed_ashraf/core/errors/failure.dart';
import 'package:mohammed_ashraf/core/respomse/basic_response.dart';
import 'package:mohammed_ashraf/features/auth/data/models/user_response.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserResponse>> login(
      {required String email, required String password});

  Future<Either<Failure, UserResponse>> register(
      {required RegisterParams registerParams, required UserType userType});

  Future<Either<Failure, BasicResponse>> forgetPassword(
      {required String email});

  Future<Either<Failure, BasicResponse>> resetPassword(
      {required String password, required String confirmPassword});

  Future<Either<Failure, BasicResponse>> verifyOtp({required String otp});

  Future<Either<Failure, BasicResponse>> logout();
}

abstract class RegisterParams {
  UserType get userType;

  Map<String, dynamic> toJson();
}

class RegisterPatientParams implements RegisterParams {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String dateOfBirth;
  final String gender;
  final String phone;
  final String country;
  final String address;

  RegisterPatientParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.dateOfBirth,
    required this.gender,
    required this.phone,
    required this.country,
    required this.address,
  });

  @override
  final UserType userType = UserType.patient;

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'phone': phone,
      'country': country,
      'address': address,
    };
  }
}

class WorkingDayParam {
  final int day;
  final String? start;
  final String? end;

  WorkingDayParam({
    required this.day,
    this.start,
    this.end,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{'day': day};
    if (start != null) map['start'] = start;
    if (end != null) map['end'] = end;
    return map;
  }
}

class RegisterDoctorParams implements RegisterParams {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String dateOfBirth;
  final String gender;
  final String phone;
  final String country;
  final String address;
  final String specialization;
  final int appointmentFee;
  final bool defaultWorkingDays;
  final List<WorkingDayParam> workingDays;

  RegisterDoctorParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.dateOfBirth,
    required this.gender,
    required this.phone,
    required this.country,
    required this.address,
    required this.specialization,
    required this.appointmentFee,
    required this.defaultWorkingDays,
    required this.workingDays,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'phone': phone,
      'country': country,
      'address': address,
      'specilization': specialization,
      'appointmentFee': appointmentFee,
      'defaultWorkingDays': defaultWorkingDays,
      'workingDays': workingDays.map((wd) => wd.toJson()).toList(),
    };
  }

  @override
  UserType get userType => UserType.doctor;
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}
