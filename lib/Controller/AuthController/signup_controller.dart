
//phone validation
import 'package:flutter/cupertino.dart';

String? tempPass;
phoneValidator(value) {
  if (value!.isEmpty) {
    return 'Enter your phone number';
  } else if (value.length == 10){
    return null;
  }else {
    return 'Enter a proper number';
  }
}

nameValidator(value, String s){
  if (value == null){
    return 'Enter a $s';
  }else if (value!.isEmpty) {
    return 'Enter a $s';
  }else{
    return null;
  }
}

locationValidator(value, String l){
  if (value == null){
    return 'Enter a $l';
  }else if (value!.isEmpty) {
    return 'Enter a $l';
  }else{
    return null;
  }
}

signUpPasswordValidator(value){
  if(value!.isEmpty || value.length < 6){
    return 'Password is to short';
  } else{
    tempPass = value;
    debugPrint("Temp password: $tempPass");
    return null;
  }
}

signUpcPasswordValidator(value){
  if(value!.isEmpty){
    return 'Confirm your password';
  }else if (tempPass != value){
    return 'Password does not match';
  }else{
    debugPrint("Confirm password: $value");
    debugPrint("Temp password: $tempPass");
    return null;
  }
}


