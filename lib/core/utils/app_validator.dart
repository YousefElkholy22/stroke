class Validator {
  static String? defaultValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }

    return null;
  }

  static String? name(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return 'This field is required';
      }
      if (value.split(' ').length < 3) {
        return 'Name must be at least 3 parts';
      }
      if (value.length < 3) {
        return 'Name is too short';
      }
    }
    return null;
  }

  static String? registerAddress(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return 'This field is required';
      }
      if (value.length < 4) {
        return 'Address is too short';
      }
    }
    return null;
  }

  static const String urlPattern =
      r'((https?:\/\/)?([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})(:[0-9]{1,5})?(\/\S*)?)';
  static RegExp urlRegex = RegExp(urlPattern);

  static String? text(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return 'This field is required';
      } else if (!RegExp('[a-zA-Z]').hasMatch(value)) {
        return 'Enter correct name';
      }
    }
    return null;
  }

  static String? defaultEmptyValidator(String? value) {
    return null;
  }

  static String? email(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return 'This field is required';
      } else if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
        return 'Invalid email';
      }
    } else {
      return 'This field is required';
    }
    return null;
  }

  static String? password(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return 'This field is required';
      }
      if (value.length < 8) {
        return 'Password must be at least 8 characters';
      }
    }
    return null;
  }

  static String? confirmPassword(String? confirmPassword, String? password) {
    if (confirmPassword != null) {
      confirmPassword = confirmPassword.trim();
      if (confirmPassword.isEmpty) {
        return 'This field is required';
      } else if (confirmPassword != password) {
        return 'Passwords do not match';
      }
    } else {
      return 'This field is required';
    }
    return null;
  }

  static String? numbers(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return 'This field is required';
      }
      if (value.startsWith('+')) {
        value = value.replaceFirst(r'+', '');
      }
      final int? number = int.tryParse(value);
      if (number == null) {
        return 'Wrong input';
      }
    } else {
      return 'This field is required';
    }
    return null;
  }

  static String? phone(String? value) {
    RegExp regExp = RegExp(r'^01[0-2-5]{1}[0-9]{8}$');
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    bool containsArabic = value.contains(RegExp(r'[٠-٩]'));
    bool containsEnglish = value.contains(RegExp(r'[0-9]'));
    if (!regExp.hasMatch(value) && (containsArabic && containsEnglish)) {
      return 'Invalid phone';
    }
    return null;
  }

  static String? positiveNumbers(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return 'This field is required';
      }
      if (value.startsWith('+')) {
        value = value.replaceFirst(r'+', '');
      }
      final double? number = double.tryParse(value);
      if (number == null) {
        return 'Wrong input';
      }
      if (number <= 0) {
        return 'Number must be positive';
      }
    } else {
      return 'This field is required';
    }
    return null;
  }
}
