import 'dart:developer';

String? Function(String?)? basicValidator() {
  return (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  };
}

String? Function(String?)? passwordValidatior() {
  return (txt) {
    if (txt == null || txt.isEmpty) {
      return "Invalid password!";
    }
    if (txt.length < 8) {
      return "Password must has 8 characters";
    }
    if (!txt.contains(RegExp(r'[A-Z]'))) {
      return "Password must has uppercase";
    }
    if (!txt.contains(RegExp(r'[0-9]'))) {
      return "Password must has digits";
    }
    if (!txt.contains(RegExp(r'[a-z]'))) {
      return "Password must has lowercase";
    }
    if (!txt.contains(RegExp(r'[#?!@$%^&*-]'))) {
      return "Password must has special characters";
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
  log(date.toIso8601String());
  return "${date.day}/${date.month}/${date.year} | ${date.hour}:${date.minute < 10 ? '0${date.minute}' : date.minute}";
}
