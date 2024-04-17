import 'package:http/http.dart' as http;
import 'package:innocart/homescreen.dart';
import 'dart:convert';

import 'package:innocart/main.dart';

class Loginservice {
  late String name;
  late String passwordMd5hash;
  late Function update;
  Loginservice(this.name, this.passwordMd5hash,this.update);

  Loginservice.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    passwordMd5hash = json['passwordMd5hash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['passwordMd5hash'] = this.passwordMd5hash;
    return data;
  }
  Future<http.Response?> post() async {
    var uri = Uri.parse('http://5.53.125.241:8000/sign_in/');
    var response = await http.post(uri,headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },body: jsonEncode(toJson()));
    print(jsonEncode(toJson()));
    print(response.body);
    if(response.statusCode == 200){
      MainState.state = AppState.CONNECTED;
      HomeScreenState.token = jsonDecode(response.body)['token'];
      HomeScreenState.id = jsonDecode(response.body)['id'];
      print(HomeScreenState.token);
      update();
    }
    return response;
  }
}
