import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:innocart/homescreen.dart';
import 'package:innocart/network/userservice.dart';
import 'package:innocart/subscreens/availableorders.dart';
import 'package:innocart/subscreens/order.dart';


class listordersservice {
  Future<void> getOrder(List<OrderBox> list, int id)async {
    print(id);
    var client = http.Client();
    print('http://5.53.125.241:8000/orders/' + id.toString() + '?token=' +
        HomeScreenState.token);
    var uri = Uri.parse(
        'http://5.53.125.241:8000/orders/' + id.toString() + '?token=' +
            HomeScreenState.token);

    var response = await client.get(uri);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var o = Order.fromJson(jsonDecode(response.body));
      list.add(OrderBox(o.id, o.name, o.description, o.expectedDeliveryTime.toString().substring(0,10),o.address, o.picture, o.cost.toString(),o.fee.toString(), o.name, 4.2, o.id, 2, [], [], (){},o.status));
  }
  }
  Future<List<Order>?> getOrders(Function f, List<OrderBox> orders,int type,String filter) async {
    var client = http.Client();

    var uri = Uri.parse('http://5.53.125.241:8000/orders/?token=' + HomeScreenState.token + filter);
    var response = await client.get(uri);

    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var json = orderFromJson(response.body);

      if(orders.isNotEmpty)orders.clear();

      for(var x in json){
        User user = await UserService().getUser((){}, x.customerId) as User;
        List<String> angelNames = ["Choose an Angel"];
        List angelIds = [-1];
        for(var y in x.possibleAngelsIds){
          var temp = await UserService().getUser((){}, y);
          if(temp == null)continue;
          User user2 = temp as User;
          angelNames.add(user2.name);
          angelIds.add(user2.id);
        }
        orders.add(OrderBox(x.id,x.name, x.description, x.expectedDeliveryTime,x.address, x.picture, x.cost.toString(),x.fee.toString(),user.name,double.parse(user.deliveryRate),user.id,type,angelNames,angelIds,f,x.status));
      }
      f();
      return json;
    }
  }
  Future<List<Order>?> getCreatedOrders(Function f, List<OrderBox> orders,int type) async {
    var client = http.Client();

    var uri = Uri.parse('http://5.53.125.241:8000/orders/?token=' + HomeScreenState.token + "&customerId=" + HomeScreenState.id.toString());
    var response = await client.get(uri);

    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var json = orderFromJson(response.body);

      if(orders.isNotEmpty)orders.clear();

      for(var x in json){
        User user = await UserService().getUser((){}, x.customerId) as User;
        List<String> angelNames = ["Choose an Angel"];
        List angelIds = [-1];
        for(var y in x.possibleAngelsIds){
          var temp = await UserService().getUser((){}, y);
          if(temp == null)continue;
          User user2 = temp as User;
          angelNames.add(user2.name);
          angelIds.add(user2.id);
        }
        orders.add(OrderBox(x.id,x.name, x.description, x.expectedDeliveryTime,x.address, x.picture, x.cost.toString(),x.fee.toString(),user.name,double.parse(user.deliveryRate),user.id,type,angelNames,angelIds,f,x.status));
      }
      orders.sort((var x,var y) => x.status.compareTo(y.status));
      f();
      return json;
    }
  }
  Future<void> getAcceptedOrders(Function f, List<OrderBox> orders,int type) async {
    var client = http.Client();
    User user = await UserService().getUser((){}, HomeScreenState.id) as User;
    print(user.deliveredOrdersHistoryIds.length);
    for(var x in user.deliveredOrdersHistoryIds){
      await getOrder(orders,x);
    }
    f();
  }
}

List<Order> orderFromJson(String str) => List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  Order(
    this.id,
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
    this.picture,
  );

  int id;
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

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    json["id"],
    json["customerId"],
    json["name"],
    json["description"],
    //DateTime.parse(json["expectedDeliveryTime"]),
    json['expectedDeliveryTime'],
    json["status"],
    json["weight"],
    json["cost"],
    json["fee"],
    json["address"],
    List<int>.from(json["possibleAngelsIds"].map((x) => x)),
    json["picture"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customerId": customerId,
    "name": name,
    "description": description,
    "expectedDeliveryTime": expectedDeliveryTime,
    "status": status,
    "weight": weight,
    "cost": cost,
    "fee": fee,
    "address": address,
    "possibleAngelsIds": List<dynamic>.from(possibleAngelsIds.map((x) => x)),
    "picture": picture,
  };
}

