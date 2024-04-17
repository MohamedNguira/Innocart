import 'dart:convert';

import 'package:http/http.dart' as http;import '../homescreen.dart';


import '../main.dart';


class Signupservice {
  String passwordMd5hash;
  String name;
  String phoneNumber;
  String email;
  int age;
  double deliveryRate;
  Function update;
  Signupservice(
       this.passwordMd5hash,
        this.name,
       this.phoneNumber,
       this.email,
      this.age,
      this.deliveryRate,
      this.update
      );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['passwordMd5hash'] = this.passwordMd5hash;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['age'] = this.age;
    data['deliveryRate'] = this.deliveryRate;
    return data;
  }
  Future<http.Response?> post() async {
    var uri = Uri.parse('http://5.53.125.241:8000/sign_up/');
    var response = await http.post(uri,headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },body: jsonEncode(toJson()));
    print(response.body);
    print(response.statusCode);
    if(response.statusCode == 201){
      MainState.state = AppState.CONNECTED;
      HomeScreenState.token = jsonDecode(response.body)['token'];
      HomeScreenState.id = jsonDecode(response.body)['id'];
      update();
    }
    MainState.state = AppState.CONNECTED;
    update();
    return response;
  }
}