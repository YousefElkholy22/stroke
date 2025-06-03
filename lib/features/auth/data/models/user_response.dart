import 'package:mohammed_ashraf/core/enums/user_type.dart';

class UserResponse {
  final String status;
  final UserData data;

  UserResponse({
    required this.status,
    required this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      status: json['status'] as String,
      data: UserData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  UserResponse copyWith({
    String? status,
    UserData? data,
  }) =>
      UserResponse(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data.toJson(),
      };
}

class UserData {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String profileImg;
  final UserType role;
  final String gender;
  final DateTime dateOfBirth;
  final String phone;
  final String country;
  final String address;

  // the "__t" discriminator from backend (Patient or Doctor)
  final String t;

  // ────────────────────────────────────────────────────────────────────────────
  // Fields that exist only for Doctor:
  final List<WorkingDay>? workingDays;
  final bool? defaultWorkingDays;
  final int? appointmentFee;

  // Fields that exist only for Patient:
  final List<String>? favoriteDoctors;
  // ────────────────────────────────────────────────────────────────────────────

  final DateTime createdAt;
  final int v;

  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profileImg,
    required this.role,
    required this.gender,
    required this.dateOfBirth,
    required this.phone,
    required this.country,
    required this.address,
    required this.t,
    this.workingDays,
    this.defaultWorkingDays,
    this.appointmentFee,
    this.favoriteDoctors,
    required this.createdAt,
    required this.v,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    // 1. Parse the discriminator "__t" (called "t" here) and role
    final String rawT = (json['__t'] as String?) ?? '';
    final String rawRole = (json['role'] as String? ?? rawT).toString();
    final userType = UserType.fromStringKey(rawRole);

    // 2. Common fields
    final id = json['_id'] as String;
    final firstName = json['firstName'] as String;
    final lastName = json['lastName'] as String;
    final email = json['email'] as String;
    final profileImg = json['profileImg'] as String;
    final gender = json['gender'] as String;
    final dob = DateTime.parse(json['dateOfBirth'] as String);
    final phone = json['phone'] as String;
    final country = json['country'] as String;
    final address = json['address'] as String;
    final createdAt = DateTime.parse(json['createdAt'] as String);
    final v = (json['__v'] is int)
        ? (json['__v'] as int)
        : int.parse(json['__v'].toString());

    // 3. Depending on role, fill doctor‐only vs patient‐only fields
    List<WorkingDay>? workingDays;
    bool? defaultWorkingDays;
    int? appointmentFee;
    List<String>? favoriteDoctors;

    if (userType == UserType.doctor) {
      // parse doctor fields
      if (json['workingDays'] is List) {
        workingDays = (json['workingDays'] as List)
            .map((e) => WorkingDay.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        workingDays = [];
      }
      defaultWorkingDays = json['defaultWorkingDays'] as bool? ?? false;
      appointmentFee = json['appointmentFee'] is int
          ? (json['appointmentFee'] as int)
          : int.tryParse(json['appointmentFee'].toString()) ?? 0;
      favoriteDoctors = null;
    } else {
      // parse patient fields
      if (json['favoriteDoctors'] is List) {
        // assuming favoriteDoctors is a list of doctor IDs (strings)
        favoriteDoctors =
            (json['favoriteDoctors'] as List).map((e) => e.toString()).toList();
      } else {
        favoriteDoctors = [];
      }
      workingDays = null;
      defaultWorkingDays = null;
      appointmentFee = null;
    }

    return UserData(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      profileImg: profileImg,
      role: userType,
      gender: gender,
      dateOfBirth: dob,
      phone: phone,
      country: country,
      address: address,
      t: rawT,
      workingDays: workingDays,
      defaultWorkingDays: defaultWorkingDays,
      appointmentFee: appointmentFee,
      favoriteDoctors: favoriteDoctors,
      createdAt: createdAt,
      v: v,
    );
  }

  UserData copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? profileImg,
    UserType? role,
    String? gender,
    DateTime? dateOfBirth,
    String? phone,
    String? country,
    String? address,
    String? t,
    List<WorkingDay>? workingDays,
    bool? defaultWorkingDays,
    int? appointmentFee,
    List<String>? favoriteDoctors,
    DateTime? createdAt,
    int? v,
  }) =>
      UserData(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        profileImg: profileImg ?? this.profileImg,
        role: role ?? this.role,
        gender: gender ?? this.gender,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        phone: phone ?? this.phone,
        country: country ?? this.country,
        address: address ?? this.address,
        t: t ?? this.t,
        workingDays: workingDays ?? this.workingDays,
        defaultWorkingDays: defaultWorkingDays ?? this.defaultWorkingDays,
        appointmentFee: appointmentFee ?? this.appointmentFee,
        favoriteDoctors: favoriteDoctors ?? this.favoriteDoctors,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
      );

  Map<String, dynamic> toJson() {
    final base = <String, dynamic>{
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'profileImg': profileImg,
      'role': role.toString().split('.').last,
      'gender': gender,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'phone': phone,
      'country': country,
      'address': address,
      '__t': t,
      'createdAt': createdAt.toIso8601String(),
      '__v': v,
    };

    if (role == UserType.doctor) {
      base.addAll({
        'workingDays': workingDays
                ?.map((wd) => {
                      'day': wd.day,
                      'start': wd.start,
                      'end': wd.end,
                    })
                .toList() ??
            [],
        'defaultWorkingDays': defaultWorkingDays,
        'appointmentFee': appointmentFee,
      });
    } else {
      base.addAll({
        'favoriteDoctors': favoriteDoctors ?? [],
      });
    }

    return base;
  }
}

class WorkingDay {
  final int day;
  final String start;
  final String end;

  WorkingDay({
    required this.day,
    required this.start,
    required this.end,
  });

  factory WorkingDay.fromJson(Map<String, dynamic> json) {
    return WorkingDay(
      day: json['day'] as int,
      start: json['start'] as String,
      end: json['end'] as String,
    );
  }

  WorkingDay copyWith({
    int? day,
    String? start,
    String? end,
  }) =>
      WorkingDay(
        day: day ?? this.day,
        start: start ?? this.start,
        end: end ?? this.end,
      );

  Map<String, dynamic> toJson() => {
        'day': day,
        'start': start,
        'end': end,
      };
}
