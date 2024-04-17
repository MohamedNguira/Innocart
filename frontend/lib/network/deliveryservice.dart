import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:innocart/homescreen.dart';
Delivery deliveryFromJson(String str) => Delivery.fromJson(json.decode(str));

String deliveryToJson(Delivery data) => json.encode(data.toJson());

class Delivery {
  Delivery(
    this.id,
    this.customerId,
    this.angelId,
    this.orderId,
    this.customerConfirmation,
    this.angelConfirmation,
  );

  int id;
  int customerId;
  int angelId;
  int orderId;
  bool customerConfirmation;
  bool angelConfirmation;

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
    json["id"],
    json["customerId"],
     json["angelId"],
     json["orderId"],
   json["customerConfirmation"],
     json["angelConfirmation"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customerId": customerId,
    "angelId": angelId,
    "orderId": orderId,
    "customerConfirmation": customerConfirmation,
    "angelConfirmation": angelConfirmation,
  };
}
class DeliveryService{
  void post(Function update, Delivery delivery) async{
    var uri = Uri.parse('http://5.53.125.241:8000/delivery/' + "?token=" + HomeScreenState.token);
    var response = await http.post(uri,headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },body: jsonEncode(delivery.toJson()));
    print(response.body);
    print(response.statusCode);
    if(response.statusCode == 201){
      update();
    }
  }
  void put(Function update, Delivery delivery) async{
    var uri = Uri.parse('http://5.53.125.241:8000/delivery/' +delivery.orderId.toString() +  "?token=" + HomeScreenState.token);
    var response = await http.put(uri,headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },body: jsonEncode(delivery.toJson()));
    print(response.body);
    print(response.statusCode);
    if(response.statusCode == 201){
      update();
    }
  }
}