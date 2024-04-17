
import 'package:flutter/material.dart';
import 'package:innocart/subscreens/addorder.dart';
import 'package:innocart/subscreens/angellist.dart';
import 'package:innocart/subscreens/availableorders.dart';
import 'package:innocart/subscreens/deliverystatus.dart';
import 'package:innocart/subscreens/mainprofile.dart';
import 'package:innocart/subscreens/order.dart';
import 'package:innocart/subscreens/ordersinprogress.dart';

import 'package:innocart/subscreens/orderview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);



  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>{

  static String token = "";
  static int id = -1;
  List<String> titles = <String>["Available Orders","Support Page","Order History","Profile","Add an Order"];
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static bool angel = true;
  List<Widget> _widgetOptionsAngel = [];
  List<Widget> _widgetOptionsCustomer= [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  static late double height,width;

  @override
  Widget build(BuildContext context) {
    _widgetOptionsCustomer = <Widget>[
      AddOrderScreen((){setState((){

      });}),
      Text("Support Page not implemented yet"),
      OrdersInProgress(title: "test"),
      ProfileScreen((){setState((){});})
    ];
    _widgetOptionsAngel = <Widget>[
      AvailableOrders(title: "title"),
      Text("Support Page not implemented yet"),
      OrdersInProgress(title: "test"),
      ProfileScreen((){setState((){});})
    ];
    double iconsize = 30;
    Size size = MediaQuery.of(context).size;
    double h = size.height, w = size.width;
    height = h;width = w;
    print(token);
    return Scaffold(

    body: Column(children: [

      Container(
          width: w,
          height: h * 0.14,
          decoration:  BoxDecoration(
            color : angel?Color.fromRGBO(181, 123, 255, 1):Color.fromRGBO(137, 141, 247, 1),
          ),
          child: Stack( children:[Align(
              alignment: Alignment(-0.8,0.7),
              child: Text(titles[(_selectedIndex == 0 && angel == false)?4:_selectedIndex], textAlign: TextAlign.left, style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Manjari',
              fontSize: 31,
              letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1
          ),)),
             if(_selectedIndex == 0 && angel == true || _selectedIndex == 2) Align(alignment: Alignment(0.7,0.7),
                  child: IconButton(icon: Image.asset("assets/images/sort.png"), onPressed: () {  },)),
            if(_selectedIndex == 0 && angel == true || _selectedIndex == 2) Align(alignment: Alignment(0.95,0.7),
                child: IconButton(icon: Image.asset("assets/images/options.png"), onPressed: () {  },)),
          ])
      ),

      Expanded(

          child: ListView(
            scrollDirection: Axis.vertical,

          children: [
            if(angel)_widgetOptionsAngel.elementAt(_selectedIndex)
            else _widgetOptionsCustomer.elementAt(_selectedIndex)
            ],

      )
      )
    ]
    ),
    bottomNavigationBar: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
    items:  <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart , color: Color(0xffc3c3d3), size: iconsize),
      label: ""
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.support, color: Color(0xffc3c3d3), size: iconsize),
        label: ""

    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.history , color: Color(0xffc3c3d3), size: iconsize),
        label: ""
    ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_pin_circle , color: Color(0xffc3c3d3), size: iconsize),
          label: ""

      )
    ],
    currentIndex: _selectedIndex,
    selectedItemColor: Colors.amber[800],
    onTap: _onItemTapped,
    ),
    )
    ;
  }

}


