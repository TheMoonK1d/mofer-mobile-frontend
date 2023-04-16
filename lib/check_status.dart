// import 'dart:convert';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart'as http;
//
// class CheckStatusUser extends StatelessWidget {
//   const CheckStatusUser({Key? key}) : super(key: key);
//
//   @override
//
//   Widget? build(BuildContext context) {
//     String? uid;
//     var exp, dsl;
//     User? user = FirebaseAuth.instance.currentUser;
//
//
//     checkUserStatus()async{
//       debugPrint("Checking user status...");
//       final data = {'customer_uid': uid};
//       final uri = Uri.http('192.168.1.6:5000','/ss/check', data);
//       final response = await http.get(uri);
//       if (response.statusCode == 200) {
//         debugPrint("Checked");
//         debugPrint(response.body);
//         var result = jsonDecode(response.body);
//         var dsl = int.parse(result['is_disabled']);
//         var exp = int.parse(result['is_expired']);
//       } else {
//         debugPrint("Something went wrong");
//         dsl = 1;
//         exp = 1;
//       }
//     }
//
//     if (user != null) {
//       uid = user.uid;
//       checkUserStatus();
//     }
//
//   }
// }
