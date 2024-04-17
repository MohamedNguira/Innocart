import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:innocart/main.dart';

class profiledetailsservice {
  late String name;
  late String passwordMd5hash;
  late Function update;
  profiledetailsservice(this.name, this.passwordMd5hash,this.update);

  profiledetailsservice.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    passwordMd5hash = json['PasswordMd5hash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['PasswordMd5hash'] = this.passwordMd5hash;
    return data;
  }
  Future<http.Response?> post() async {
    var uri = Uri.parse('http://5.53.125.241:8000/sign_in/');
    var response = await http.post(uri,headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },body: jsonEncode(toJson()));
    print(response.body);
    print(response.statusCode);
    if(response.statusCode == 200){
      MainState.state = AppState.CONNECTED;
      update();
    }
    return response;
  }
  dynamic getAngelDetails(String id){

  }

}
class Angel{

}