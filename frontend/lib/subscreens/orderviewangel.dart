
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:innocart/network/changeorderstatus.dart';
import 'package:innocart/subscreens/availableorders.dart';

import '../homescreen.dart';

import '../network/deliveryservice.dart';
import '../network/userservice.dart';
import 'order.dart';
import 'ordersinprogress.dart';
import 'orderview.dart';

class OrderViewAngel extends StatefulWidget {
  OrderViewAngel(this.order,this.call,{Key? key}) : super(key: key);
  OrderBox order;
  Function call;
  @override
  State<StatefulWidget> createState() => OrderViewAngelState();
}

class OrderViewAngelState extends State<OrderViewAngel>{
  User customer = User(0,"","","",0,"",[],[]);
  static late Function back;
  Color c = HomeScreenState.angel?Color(0xff803bf0):Color(0xff3B42F0);
  @override
  void initState(){
    UserService().getUserProfile((){
      setState((){});
    }, widget.order.customerId,customer);
  }
  @override
  Widget build(BuildContext context) {
    double h = HomeScreenState.height, w = HomeScreenState.width;
    Size size = MediaQuery.of(context).size;
    return Align(
        alignment: Alignment.center,
        child:SizedBox(width: w * 0.9, child:
        Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            TextButton(onPressed: (){

              back();
            }, child: Icon(Icons.arrow_back)),
            Text(
              "Price:    "+ widget.order.price + " ₽ Tips:      " + widget.order.fee + "₽\n",
              style: TextStyle(color: c,
                  fontSize: 20
              ),
            ),
            Container(height:2, width:w * 0.9,color: Color.fromRGBO(0xd4, 0xe0, 0xff, 1)),
            SizedBox(
                height: h * 0.4,
                child:
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        alignment: Alignment(-.2, 0),
                        image: NetworkImage(
                            widget.order.urlpic),
                        fit: BoxFit.cover),
                  ),
                  alignment: Alignment.bottomCenter,
                )
            ),
            Container(height:1, width:w * 0.9,color: Color.fromRGBO(0xd4, 0xe0, 0xff, 1)),
            Row(
              children: [
                Text('Customer: ' + customer.name, textAlign: TextAlign.left, style: const TextStyle(
                    color: Colors.blue,
                    fontFamily: 'Manjari',
                    fontSize: 19,
                    letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1
                ),),
                SizedBox(width: 20),
                TextButton(child: Text("View Profile"),onPressed: (){
                  show();
                },)
              ],),
            SizedBox(height: h * 0.05),
            Text('Delivery time: before ' + widget.order.time + '\nDelivery address: ' + widget.order.time, textAlign: TextAlign.left, style: TextStyle(
                color: c,
                fontFamily: 'Manjari',
                fontSize: 19,
                letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1
            )),
            SizedBox(height: 10),TextButton( style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(w * 0.87,50)),
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
                )),onPressed: () {


            },
                child: Align( alignment: Alignment.center, child:Text('Start Order',style: TextStyle(

                    color: Colors.white,
                    fontSize: 20),))),

          ],
        )
        ));
  }
  Future<void> show() async {
    int id = widget.order.customerId;
    User angel = await UserService().getUser((){}, id) as User;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {

        return AlertDialog(
          title: Text(angel.name),
          content: Stack(
            children: <Widget>[
              Positioned(
                  top: 0,left:0,
                  child: RatingBar.builder(
                    itemSize: 20,
                    initialRating: double.parse(angel.deliveryRate),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.blue,
                    ),
                    onRatingUpdate: (rating) {
                    },
                  )),
              Positioned(
                  top: 0,left: 0,child:
              Icon(Icons.person,size: 20)
              )
            ],

          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}



