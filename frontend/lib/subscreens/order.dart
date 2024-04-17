import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:innocart/homescreen.dart';
import 'package:innocart/network/addangelservice.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:innocart/subscreens/availableorders.dart';
import 'package:innocart/subscreens/deliverystatus.dart';
import 'package:innocart/subscreens/ordersinprogress.dart';
import 'package:innocart/subscreens/orderview.dart';
import 'angellist.dart';
import 'orderviewangel.dart';

class OrderBox extends StatefulWidget {
  OrderBox(
      this.id,
      this.title,
      this.desc,
      this.time,
      this.address,
      this.urlpic,
      this.price,
      this.fee,
      this.customerName,
      this.customerRating,
      this.customerId,
      this.state,
      this.angelNames,
      this.angelIds,
      this.onClick,
      this.status,
      {Key? key})
      : super(key: key);
  String title, desc, time, urlpic, price, fee, customerName, status, address;
  int customerId, id;
  Icon customerImage = const Icon(Icons.person);
  double customerRating;
  Function onClick;
  List<String> angelNames;
  List angelIds;
  int state =
      1; //Angel Request(0) - Orders in progress customers (1) - Basic box for delivery (2)
  @override
  State<StatefulWidget> createState() => OrderBoxState();
}

class OrderBoxState extends State<OrderBox> {
  String dropdownValue = 'Choose an Angel';
  String angelName = "";
  @override
  void initState() {}
  @override
  Widget build(BuildContext context) {
    if (widget.status == "1") widget.state = 2;
    Size size = MediaQuery.of(context).size;
    double h = HomeScreenState.height, w = HomeScreenState.width;
    int s = widget.state;
    bool requested = super.widget.angelIds.contains(HomeScreenState.id);
    return TextButton(
        onPressed: () {
          if (widget.state >= 1) {
            if (widget.status == "0") {
              OrdersInProgressState.state = "out";
              OrdersInProgressState.current = OrderView(widget, widget.onClick);
              widget.onClick();
            } else if (widget.status == "1") {
              OrdersInProgressState.state = "out";
              OrdersInProgressState.current =
                  DeliveryStatus(widget.onClick, order: widget);
              OrdersInProgressState.refresh();
            }
          } else {
            print("test");
            AvailableOrdersState.state = "out";
            AvailableOrdersState.current =
                OrderViewAngel(widget, widget.onClick);
            widget.onClick();
          }
        },
        child: Stack(children: [
          Container(
              width: 0.9 * w,
              height: h * 0.16,
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              )),
          Positioned(
              left: 10,
              top: 15,
              child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.network(widget.urlpic))),
          Positioned(
              left: 130,
              top: 12,
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Manrope',
                    fontSize: 30,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          Positioned(
              left: 150,
              top: 60,
              child: Text(
                widget.time,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Manjari',
                    fontSize: 12,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          Positioned(
              left: 130,
              top: 59,
              child: Image.asset("assets/images/truck.png", scale: 49)),
          Positioned(
            left: 275,
            top: 10,
            child: Text(
              widget.price,
              textAlign: TextAlign.right,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.w900),
            ),
          ),
          Positioned(
            left: 305,
            top: 45,
            child: Text(
              "RUB",
              textAlign: TextAlign.right,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w900),
            ),
          ),
          if (s == 0)
            Positioned(
                left: 130,
                top: 80,
                child: SizedBox(child: widget.customerImage)),
          if (s == 0)
            Positioned(
                left: 160,
                top: 88,
                child: Text(widget.customerName,
                    style: const TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Manjari',
                        fontSize: 14,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1))),
          if (s == 0)
            Positioned(
                left: 135,
                top: 105,
                child: RatingBar.builder(
                  itemSize: 15,
                  initialRating: widget.customerRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                )),
          if (s == 0)
            Positioned(
                left: 260,
                top: 80,
                child: TextButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(w * 0.2, 20)),
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        Color current = requested
                            ? Color.fromRGBO(0xc3, 0xc3, 0xc3, 1)
                            : buttonsColor2;
                        if (states.contains(MaterialState.hovered))
                          return current.withOpacity(0.7);
                        if (states.contains(MaterialState.focused) ||
                            states.contains(MaterialState.pressed))
                          return current.withOpacity(0.6);
                        return current; // Defer to the widget's default.
                      },
                    ),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    addangelservice service =
                        addangelservice([HomeScreenState.id]);
                    service.put(AvailableOrdersState.reload, widget.id);
                  },
                  child: Text(
                    requested ? 'Request Sent' : 'Send request',
                    textScaleFactor: 0.7,
                  ),
                )),
          if (widget.status == "0" && widget.state == 1)
            Positioned(
                left: 240,
                top: 90,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(43),
                      topRight: Radius.circular(43),
                      bottomLeft: Radius.circular(43),
                      bottomRight: Radius.circular(43),
                    ),
                    color: Color.fromRGBO(240, 135, 59, 1),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Select angel',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Manjari',
                          fontSize: 12,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                )),
          if (widget.status == "1")
             Positioned(
                left: 245,
                top: 90,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius : BorderRadius.only(
                      topLeft: Radius.circular(43),
                      topRight: Radius.circular(43),
                      bottomLeft: Radius.circular(43),
                      bottomRight: Radius.circular(43),
                    ),
                    color : Color.fromRGBO(255, 206, 36, 1),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,

                    children: <Widget>[
                      Text('In Progress', textAlign: TextAlign.left, style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Manjari',
                          fontSize: 12,
                          letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1
                      ),),

                    ],
                  ),
                )),
          if (widget.status == "2")
            Positioned(
                left: 250,
                top: 90,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius : BorderRadius.only(
                      topLeft: Radius.circular(43),
                      topRight: Radius.circular(43),
                      bottomLeft: Radius.circular(43),
                      bottomRight: Radius.circular(43),
                    ),
                    color : Color.fromRGBO(64, 238, 49, 1),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,

                    children: <Widget>[
                      Text('Delivered', textAlign: TextAlign.left, style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Manjari',
                          fontSize: 12,
                          letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1
                      ),),

                    ],
                  ),
                )),
        ]));
  }

  Color buttonsColor1 = Color(0xffc3c3d3);
  Color buttonsColor2 = Color(0xff3b42f0);
}
