
import 'package:flutter/material.dart';
import 'package:innocart/network/listordersservice.dart';
import 'package:innocart/subscreens/orderviewangel.dart';

import '../homescreen.dart';
import 'order.dart';

class AvailableOrders extends StatefulWidget {
  AvailableOrders({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  State<StatefulWidget> createState() => AvailableOrdersState();
}

class AvailableOrdersState extends State<AvailableOrders>{

  static late Function reload;
  List<OrderBox> orders = <OrderBox>[];
  static Widget current = Column();
  static String state = "home";
  @override
  void initState(){
    listordersservice().getOrders((){setState((){});},orders,0,"&status=0");
  }
  @override
  Widget build(BuildContext context) {
    double h = HomeScreenState.height, w = HomeScreenState.width;
    reload = (){
      setState((){
        orders.clear();
        listordersservice().getOrders((){setState((){});},orders,0,"&status=0");
      });
    };
    OrderViewAngelState.back = (){
      setState((){
        AvailableOrdersState.state = "home";
      });
    };
    Size size = MediaQuery.of(context).size;
    print(state);
    if(state == "home")current = Column(children: orders);
    return current;
  }

}



