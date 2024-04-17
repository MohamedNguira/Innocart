import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:innocart/network/changeorderstatus.dart';

import '../homescreen.dart';

import '../network/deliveryservice.dart';
import '../network/userservice.dart';
import 'order.dart';
import 'ordersinprogress.dart';

class OrderView extends StatefulWidget {
  OrderView(this.order, this.call, {Key? key}) : super(key: key);
  OrderBox order;
  Function call;
  @override
  State<StatefulWidget> createState() => OrderViewState();
}

class OrderViewState extends State<OrderView> {
  String dropdownValue = 'Choose an Angel';
  static late Function back;

  Color c = HomeScreenState.angel ? Color(0xff803bf0) : Color(0xff3B42F0);
  @override
  Widget build(BuildContext context) {
    double h = HomeScreenState.height, w = HomeScreenState.width;
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        width: w * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              TextButton(
                  onPressed: () {
                    OrdersInProgressState.state = "list";
                    back();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        Color c = Color.fromRGBO(0xfa, 0xfa, 0xfa, 1);
                        if (states.contains(MaterialState.hovered))
                          return c.withOpacity(0.7);
                        if (states.contains(MaterialState.focused) ||
                            states.contains(MaterialState.pressed))
                          return c.withOpacity(0.6);
                        return c; // Defer to the widget's default.
                      },
                    ),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  child: Icon(Icons.arrow_back)),
              SizedBox(
                  height: h * 0.35,
                  child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          width: w * 0.6,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                alignment: Alignment(0, 0),
                                image: NetworkImage(widget.order.urlpic),
                              ),
                            ),
                            alignment: Alignment.bottomCenter,
                          )))),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [

              Container(
                  decoration: BoxDecoration(
                      color: Color(0xffd4e0ff),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Price: " + widget.order.price + "₽",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.normal,color: Colors.black),
                      ))),

    SizedBox(width: 10,),
              Container(
                  decoration: BoxDecoration(
                      color: Color(0xffd4e0ff),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Tips: " + widget.order.fee + "₽",
                        textAlign: TextAlign.center,
                        style: TextStyle(

                            fontSize: 19,
                            fontWeight: FontWeight.normal,color: Colors.black),
                      ))),
            ]),

            //Container(height:1, width:w * 0.9,color: Color.fromRGBO(0xd4, 0xe0, 0xff, 1)),

            SizedBox(height: h * 0.01),
            Container(
                decoration: BoxDecoration(
                    color: Color(0xffd4e0ff),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Date: ' +
                          widget.order.time ,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.normal,color: Colors.black),
                    ))),
            SizedBox(height: h * 0.01),
            Container(
                decoration: BoxDecoration(
                    color: Color(0xffd4e0ff),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Address: ' +
                          widget.order.address ,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.normal,color: Colors.black),
                    ))),
            SizedBox(height: h * 0.01),
            Container(
                width: w * 0.85,
                decoration: BoxDecoration(
                  borderRadius : BorderRadius.only(
                    topLeft: Radius.circular(3),
                    topRight: Radius.circular(3),
                    bottomLeft: Radius.circular(3),
                    bottomRight: Radius.circular(3),
                  ),
                  border : Border.all(
                    color: Color.fromRGBO(212, 224, 255, 1),
                    width: 1,
                  ),
                ),

                child: Padding(padding: EdgeInsets.all(10),
                 child:Text('Product Details:\n ' + widget.order.desc,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Manjari',
                        fontSize: 14,
                        letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1))),
            )
            ,
            Row(crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(top: 10),
                    child:
                    Text('Angel:',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: c,
                            fontFamily: 'Manjari',
                            fontSize: 19,
                            letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1))),
                SizedBox(width: 20),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      dropdownValue = newValue.toString();
                    });
                  },
                  items: widget.order.angelNames
                      .map<DropdownMenuItem<String>>((String value1) {
                    return DropdownMenuItem<String>(
                      value: value1,
                      child: Text(value1),
                    );
                  }).toList(),
                ),SizedBox(width: 50),
                TextButton(
                  child: Text("View Profile"),
                  onPressed: () {
                    show();
                  },
                )
              ],
            ),
            SizedBox(height: h * 0.02),

            TextButton(
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(w * 0.87, 50)),
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        Color c = Color.fromRGBO(59, 66, 240, 1);
                        if (states.contains(MaterialState.hovered))
                          return c.withOpacity(0.7);
                        if (states.contains(MaterialState.focused) ||
                            states.contains(MaterialState.pressed))
                          return c.withOpacity(0.6);
                        return c; // Defer to the widget's default.
                      },
                    )),
                onPressed: () {
                  if (dropdownValue == "Choose an angel") return;
                  int id = widget.order
                      .angelIds[widget.order.angelNames.indexOf(dropdownValue)];
                  Delivery delivery = Delivery(
                      0, HomeScreenState.id, id, widget.order.id, false, false);
                  OrdersInProgressState.state = "list";
                  DeliveryService().post(back, delivery);
                  ChangeStatusService service = ChangeStatusService("1");
                  service.put(widget.order.id);
                },
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Start Order',
                      style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: 'Manjari',fontWeight: FontWeight.bold,),
                    ))),
            SizedBox(height: 10),
            TextButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(w * 0.87, 50)),
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      Color c = Color.fromRGBO(0xc3, 0xc3, 0xc3, 1);
                      if (states.contains(MaterialState.hovered))
                        return c.withOpacity(0.7);
                      if (states.contains(MaterialState.focused) ||
                          states.contains(MaterialState.pressed))
                        return c.withOpacity(0.6);
                      return c; // Defer to the widget's default.
                    },
                  ),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {},
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Cancel Order',
                      style: TextStyle(fontSize: 20,fontFamily: 'Manjari',fontWeight: FontWeight.bold),
                    ))),

          ],
        ));
  }

  Future<void> show() async {
    int id =
        widget.order.angelIds[widget.order.angelNames.indexOf(dropdownValue)];
    User angel = await UserService().getUser(() {}, id) as User;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
              height: 100,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      top: 10,
                      left: 100,
                      child: Text(angel.name,
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Manjari',
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                          ))),
                  Positioned(
                      top: 45,
                      left: 100,
                      child: RatingBar.builder(
                        itemSize: 20,
                        initialRating: double.parse(angel.deliveryRate),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Color.fromRGBO(59, 66, 240, 1),
                        ),
                        onRatingUpdate: (rating) {},
                      )),
                  Positioned(
                      top: 0, left: -10, child: Icon(Icons.person, size: 100)),
                  Positioned(
                      top: 70,
                      left: 180,
                      child: TextButton(
                        child: const Text('Close',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Manjari',
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                color: Color.fromRGBO(59, 66, 240, 1))),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ))
                ],
              )),
        );
      },
    );
  }
}
