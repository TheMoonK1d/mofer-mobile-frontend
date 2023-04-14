
passwordValidator(value){
  if(value!.isEmpty || value.length < 6){
    return 'Password is to short';
  }else{
    return null;
  }
}

