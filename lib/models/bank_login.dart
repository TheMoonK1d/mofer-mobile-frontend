import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mofer/Views/Bank_view/bank_otp.dart';
var result, token, phone, order_id, uid;

//late String phone, pin, amount;



class Bank
  {
    final BuildContext context;

    //Bank(String phone, pin, amount);

    Bank(this.context);


  bankLoginDataSender(String amount, id, uid)async{
    debugPrint("Ready to send");
    debugPrint("Received: $amount, $id, $uid");
    final Map<String, dynamic> data = {
      'username': 'eyob',
      'password': '12345678',
    };
    final uri = Uri.http('192.168.1.6:7000','/useraccount/login', data);
    var response = await http.get(uri);
    if (response.statusCode == 200) {

      debugPrint(response.body);
      result = jsonDecode(response.body);
      token = result['Authorization'];
      debugPrint("Token: $token");
      getOrder(amount, id, uid);

    } else {
      debugPrint("something went wrong");
      debugPrint(response.body);
    }
  }


  getOrder(amount, id, uid) async {
    //http://192.168.1.6:7000/order/order

    debugPrint("Getting order");
    debugPrint("$amount, $id, ${uid}");
    final Map<String, int> order = {
      'amount': int.parse(amount),
      'receiver': 10000002,
    };
    final http.Response response = await http.post(
            Uri.parse('http://192.168.1.6:7000/order/order'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'authorization': '$token',
        },
            body: jsonEncode(order),
          );

      if (response.statusCode == 200) {
        debugPrint('successful');
        debugPrint(response.body);
        result = jsonDecode(response.body);
         phone = result['phonenumber'];
         order_id = result['order_id'];
         debugPrint("Phone: $phone, Order ID: $order_id, UID: ${uid} ID: $id");
        if (context.mounted) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>  OTPPage(phone: phone, order_id: order_id, token: token, uid: uid.toString(), id: id.toString())));
        }


      } else {
        debugPrint(response.body);
        debugPrint('Error ${response.statusCode}: ${response.reasonPhrase}');
      }
  }


  // Future<void> sendDataAllInfo() async {
  //   debugPrint("Ready to send data");
  //   final Map<String, dynamic> data = {
  //     'customer_fname': widget.fName,
  //     'customer_lname': widget.lName,
  //     'customer_email': widget.email,
  //     'customer_phone_no': widget.phone,
  //     'customer_type': 'app user',
  //     'city': widget.city,
  //     'kebele': widget.kebele,
  //     'street': widget.street,
  //   };
  //   final http.Response response = await http.post(
  //     Uri.parse(url),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(data),
  //   );
  //   if (response.statusCode == 200) {
  //     debugPrint('successful');
  //     if (context.mounted){
  //       Navigator.push(context, MaterialPageRoute(builder: (context)=> const PaymentPage()));
  //     }
  //
  //   } else {
  //     debugPrint('Error ${response.statusCode}: ${response.reasonPhrase}');
  //   }
  // }

  // getToken() async {
  //   debugPrint("Fetching data");
  //   final response =
  //   await http.get(Uri.parse('http://192.168.1.6:5000/p/allPackages'));
  //   debugPrint(response.statusCode.toString());
  //   data = jsonDecode(response.body);
  //   setState(() {
  //     lst = data!["data"];
  //   });
  //   debugPrint(lst.toString());
  // }
}