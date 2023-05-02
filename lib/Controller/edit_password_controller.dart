String? tempPass;
editPasswordValidator(value) {
  if (value!.isEmpty || value.length < 6) {
    return 'Your new password is to short';
  } else {
    tempPass = value;
    return null;
  }
}

editCPasswordValidator(value) {
  if (value!.isEmpty) {
    return 'Confirm your new password';
  } else if (tempPass != value) {
    return 'Password does not match';
  } else {
    return null;
  }
}
