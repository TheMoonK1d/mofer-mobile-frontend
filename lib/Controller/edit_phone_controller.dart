newPhoneValidator(value) {
  if (value!.isEmpty) {
    return 'Enter your new phone number';
  } else if (value.length == 10) {
    return null;
  } else {
    return 'Enter a proper number';
  }
}
