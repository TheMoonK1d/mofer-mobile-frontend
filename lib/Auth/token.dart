import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Views/check_status.dart';

class Token {
  localSave(t) async {
    debugPrint("Saving token");
    final pref = await SharedPreferences.getInstance();
    await pref.setString('Token', t.toString());
    debugPrint("Data saved locally");


  }
}
