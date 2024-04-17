
import 'package:flutter/material.dart';

import 'package:innocart/network/profiledetailsservice.dart';

import 'package:innocart/subscreens/angel.dart';
import '../homescreen.dart';
import 'order.dart';

class AngelList extends StatefulWidget {
  AngelList({Key? key,required this.order}) : super(key: key);
  OrderBox order;

  @override
  State<StatefulWidget> createState() => AngelListState();
}

class AngelListState extends State<AngelList>{




  @override
  Widget build(BuildContext context) {
    double h = HomeScreenState.height, w = HomeScreenState.width;
    Size size = MediaQuery.of(context).size;
    var angels = <Widget>[
      super.widget.order,
      AngelBox(),AngelBox(),AngelBox(),AngelBox()
    ];

    return
      Column(
          children: angels
      );
  }
}



