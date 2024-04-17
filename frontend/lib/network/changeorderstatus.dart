import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:innocart/homescreen.dart';

class ChangeStatusService {
  String status;

  ChangeStatusService(this.status);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
  Future<http.Response?> put(int orderid) async {
    var uri = Uri.parse('http://5.53.125.241:8000/orders/' + orderid.toString() +  '?token=' + HomeScreenState.token);
    var response = await http.put(uri,headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },body: jsonEncode(toJson()));
    print(response.body);
    print(response.statusCode);
    return response;
  }
}