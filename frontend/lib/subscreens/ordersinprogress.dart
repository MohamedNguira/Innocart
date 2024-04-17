
import 'package:flutter/material.dart';
import 'package:innocart/subscreens/orderview.dart';

import '../homescreen.dart';
import '../network/listordersservice.dart';
import 'deliverystatus.dart';
import 'order.dart';

class OrdersInProgress extends StatefulWidget {
  OrdersInProgress({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  State<StatefulWidget> createState() => OrdersInProgressState();
}

class OrdersInProgressState extends State<OrdersInProgress>{

  List<OrderBox> orders = <OrderBox>[];
  Widget OrdersList = Column();
  static late Function refresh;
  @override
  void initState(){
    if(HomeScreenState.angel)listordersservice().getAcceptedOrders((){setState((){});}, orders,1);
    listordersservice().getCreatedOrders((){setState((){});},orders,1);
  }
  static String state = "list";
  static Widget current = Text("Loading");
  @override
  Widget build(BuildContext context) {
    DeliveryStatusState.update = (){
      setState((){

      });
    };
    refresh = (){
      setState((){

      });
    };
    OrderViewState.back = (){
      setState((){

      });
    };

    double h = HomeScreenState.height, w = HomeScreenState.width;
    Size size = MediaQuery.of(context).size;
    OrdersList = Column(children: orders);
    if(state == "list") current = OrdersList;
    return Column(
        children:
    [
      if(state == "list")
      TextButton(
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(Size(w * 0.9,50)),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              Color c =  Color.fromRGBO(59, 66, 240, 1);
              if (states.contains(MaterialState.hovered))
                return c.withOpacity(0.7);
              if (states.contains(MaterialState.focused) ||
                  states.contains(MaterialState.pressed))
                return c.withOpacity(0.6);
              return c; // Defer to the widget's default.
            },
          ),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        onPressed: () {
          if(HomeScreenState.angel)listordersservice().getAcceptedOrders((){setState((){});}, orders,1);
          listordersservice().getCreatedOrders((){setState((){});},orders,1);
        },
        child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Icon(Icons.refresh,color: Colors.white),
        SizedBox(width: 20),
        Text('Refresh', textAlign: TextAlign.center, style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Manjari',
            fontSize: 20,
            letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.5
        ),),])
      ),
    current
    ]);
  }

}



