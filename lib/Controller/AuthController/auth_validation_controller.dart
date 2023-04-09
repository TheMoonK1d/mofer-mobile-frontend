import 'package:email_validator/email_validator.dart';

emailValidator(email){
  if (email!.isEmpty) {
    return 'Enter your email';
  } else if (!EmailValidator.validate(email)){
    return 'Enter a proper email';
  }else {
    return null;
  }
}