String? Function(String?)? basicValidator() {
  return (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  };
}
