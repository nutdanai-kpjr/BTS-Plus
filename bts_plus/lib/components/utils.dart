import 'dart:developer';

import 'package:flutter/cupertino.dart';

String? Function(String?)? basicValidator() {
  return (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value';
    }
    if (value.length >= 50) {
      return "Please enter a value less than 50 characters";
    }

    return null;
  };
}

String? Function(String?)? nameValidator() {
  return (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value';
    }
    if (value.length >= 50) {
      return "Please enter a value less than 50 characters";
    }
    if (!value.contains(RegExp(r'^[a-zA-Z]*$'))) {
      return "Please enter only alphabets";
    }
    return null;
  };
}

String? Function(String?)? passwordValidatior() {
  return (txt) {
    if (txt == null || txt.isEmpty) {
      return "Please enter a password";
    }
    if (txt.length < 6) {
      return "Password must has at least 6 characters";
    }
    // if (!txt.contains(RegExp(r'[A-Z]'))) {
    //   return "Password must has uppercase";
    // }
    // if (!txt.contains(RegExp(r'[0-9]'))) {
    //   return "Password must has digits";
    // }
    // if (!txt.contains(RegExp(r'[a-z]'))) {
    //   return "Password must has lowercase";
    // }
    // if (!txt.contains(RegExp(r'[#?!@$%^&*-]'))) {
    //   return "Password must has special characters";
    // }
    return null;
  };
}

String? Function(String?)? confirmPasswordValidatior(
    TextEditingController orginalPasswordController) {
  return (txt) {
    if (txt == null || txt.isEmpty) {
      return "Please enter a password";
    }
    if (txt.length < 6) {
      return "Password must has at least 6 characters";
    }
    // if (!txt.contains(RegExp(r'[A-Z]'))) {
    //   return "Password must has uppercase";
    // }
    // if (!txt.contains(RegExp(r'[0-9]'))) {
    //   return "Password must has digits";
    // }
    // if (!txt.contains(RegExp(r'[a-z]'))) {
    //   return "Password must has lowercase";
    // }
    if (txt != orginalPasswordController.text) {
      return "Password does not match";
    }
    return null;
  };
}

String? Function(String?)? pinValidatior() {
  return (txt) {
    if (txt == null || txt.isEmpty) {
      return "Please enter a PIN";
    }

    if (!txt.contains(RegExp(r'^([0-9]{6}$)'))) {
      return "PIN must has 6 digits";
    }

    return null;
  };
}

String? Function(String?)? confirmPinValidatior(
    TextEditingController orginalPinController) {
  return (txt) {
    if (txt == null || txt.isEmpty) {
      return "Please enter a PIN";
    }

    if (!txt.contains(RegExp(r'^([0-9]{6}$)'))) {
      return "PIN must has only 6 digits";
    }
    if (txt != orginalPinController.text) {
      return "PIN does not match";
    }

    return null;
  };
}

String? Function(String?)? birthDateValidator(TextEditingController date) {
  return (txt) {
    DateTime now = DateTime.now();
    DateTime birthdate = DateTime.parse(date.text);

    int age = now.year - birthdate.year;
    log(age.toString());
    if (txt == null || txt.isEmpty) {
      return 'Please enter a value';
    }
    if (age < 15) {
      return 'You must be at least 15 years old to register';
    }
    if (age > 120) {
      return 'You must be less than 120 years old to register';
    }

    return null;
  };
}

String? Function(String?)? userNameValidator() {
  return (txt) {
    if (txt == null || txt.isEmpty) {
      return 'Please enter a value';
    }
    if (txt.length < 6) {
      return "Username must has at least 6 characters";
    }
    if (txt.length >= 30) {
      return "Please enter a value less than 30 characters";
    }
    if (txt.contains(RegExp(r'[#?!@$%^&*-]'))) {
      return "Username must not has any special characters";
    }
    return null;
  };
}

String getCapitalized(String str) {
  return str.isNotEmpty
      ? str.substring(0, 1).toUpperCase() + str.substring(1).toLowerCase()
      : str;
}

String getFormatDate(DateTime date) {
  return "${date.day}/${date.month}/${date.year}";
}

String getFormatDateWithTime(DateTime date) {
  return "${date.day}/${date.month}/${date.year} | ${date.hour}:${date.minute < 10 ? '0${date.minute}' : date.minute}";
}
