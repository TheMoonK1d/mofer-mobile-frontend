editLocationValidator(value, String l) {
  if (value == null) {
    return 'Enter a $l';
  } else if (value!.isEmpty) {
    return 'Enter a $l';
  } else {
    return null;
  }
}
