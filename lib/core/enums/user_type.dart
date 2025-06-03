// ignore_for_file: constant_identifier_names

const String DOCTOR = 'DOCTOR';
const String PATIENT = 'PATIENT';
const String ADMIN = 'ADMIN';

enum UserType {
  doctor,
  patient,
  admin;

  String getServerString() {
    switch (this) {
      case UserType.doctor:
        return DOCTOR;
      case UserType.patient:
        return PATIENT;
      case UserType.admin:
        return ADMIN;
    }
  }

  static UserType fromStringKey(String key) {
    switch (key) {
      case DOCTOR:
        return UserType.doctor;
      case PATIENT:
        return UserType.admin;
      default:
        return UserType.patient;
    }
  }
}
