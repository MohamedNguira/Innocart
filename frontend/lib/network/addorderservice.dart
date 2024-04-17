import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:innocart/homescreen.dart';

class AddOrderService {
  int customerId;
  String name;
  String description;
  String expectedDeliveryTime;
  String status;
  String weight;
  int cost;
  int fee;
  String address;
  List<int> possibleAngelsIds;
  String picture;

  AddOrderService(
      this.customerId,
        this.name,
        this.description,
        this.expectedDeliveryTime,
        this.status,
        this.weight,
        this.cost,
        this.fee,
        this.address,
        this.possibleAngelsIds,
        this.picture);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['expectedDeliveryTime'] = this.expectedDeliveryTime;
    data['status'] = this.status;
    data['weight'] = this.weight;
    data['cost'] = this.cost;
    data['fee'] = this.fee;
    data['address'] = this.address;
    data['possibleAngelsIds'] = this.possibleAngelsIds;
    data['picture'] = this.picture;
    return data;
  }
  Future<http.Response?> post() async {
    var uri = Uri.parse('http://5.53.125.241:8000/orders/?token=' + HomeScreenState.token);
    var response = await http.post(uri,headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },body: jsonEncode(toJson()));
    print(response.body);
    print(response.statusCode);
    return response;
  }
}
