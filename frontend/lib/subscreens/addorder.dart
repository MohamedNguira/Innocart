
import 'package:flutter/material.dart';
import 'package:innocart/network/addorderservice.dart';
import 'package:table_calendar/table_calendar.dart';

import '../homescreen.dart';
import 'order.dart';

class AddOrderScreen extends StatefulWidget {
  AddOrderScreen(this.f,{Key? key}) : super(key: key);
  Function f;


  @override
  State<StatefulWidget> createState() => AddOrderScreenState();
}

class AddOrderScreenState extends State<AddOrderScreen>{



  late String name,time,address,price,tips,details;
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double h = HomeScreenState.height, w = HomeScreenState.width;
    Size size = MediaQuery.of(context).size;
    return  Align( child: SizedBox(width: w * 0.9, child:Column(


      children: [
        SizedBox(height: 30),
        TextField(
          obscureText: false,

          onChanged: (String value) async{

            setState((){
                name = value;
            });
          },
          decoration: const InputDecoration(

            border: const OutlineInputBorder(),
            labelText: 'Product Name',
          ),
        ),SizedBox(height:20),
        TextField(
          obscureText: false,
          onChanged: (String value) async{

            setState((){
                time = value;
            });
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Delivery time',
            suffixIcon: TextButton(onPressed: () {
              _showMyCalendar();
            },
            child:Image.asset("assets/images/calendar.png", height: 30,color: Colors.grey,))
          ),
        ),SizedBox(height:20),
        TextField(
          obscureText:false,
          onChanged: (String value) async{

            setState((){
              address = value;
            });
          },
          decoration:  InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Address of the delivery',
              suffixIcon: TextButton(onPressed: () {

              },
                  child:Image.asset("assets/images/location.png", height: 30,color: Colors.grey))
          ),
        ),SizedBox(height:20),
        Row(children: [
          SizedBox(width: w * 0.45, height: h * 0.1, child:
          TextField(
            onChanged: (String value) async{

              setState((){
                  price = value;
              });
            },
            decoration: InputDecoration(

              border: OutlineInputBorder(),
              labelText: 'Price',
                suffixIcon: TextButton(onPressed: () {

                },
                    child:Image.asset("assets/images/currency1.png", height: 25,color: Colors.grey))
            ),
          )),
          SizedBox(width: w * 0.45, height: h * 0.1, child: TextField(

            onChanged: (String value) async{

              setState((){
                  tips = value;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Delivery Tips',
                suffixIcon: TextButton(onPressed: () {

                },
                    child:Image.asset("assets/images/currency.png", height: 25,color: Colors.grey))
            ),
          ))
        ],)
      ,  SizedBox(width: w * 0.9, height: h * 0.15, child: TextField(

          onChanged: (String value) async{

            setState((){
                details = value;
            });
          },
          expands: true,
         maxLines: null,
         minLines: null,

          decoration: InputDecoration(

              border: OutlineInputBorder(),
              labelText: 'Product Details',
              suffixIcon:SizedBox(width: 40,child:Align(
                  alignment: Alignment(-1,-0.8),
                  child: Image.asset("assets/images/image.png", height: 25,color: Colors.grey))),
            suffixIconConstraints: BoxConstraints(

            )
          ),
        )),
        SizedBox(height: 50),
        TextButton(

          onPressed: () {

            AddOrderService service = AddOrderService(HomeScreenState.id, name, details, time, "0", "50", int.parse(price), int.parse(tips), address, [], "https://cdn-icons-png.flaticon.com/512/1067/1067555.png");
            var x = service.post();
            _showMyDialog();
            super.widget.f();
            },
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
          child:
          Text('Create order', textAlign: TextAlign.center, style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Manjari',
              fontSize: 17,
              letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 2
          ),),
        )
        ],
    )
    ))
    ;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Order has been created'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('You have to wait until angels submit to process your order'),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> _showMyCalendar() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Order has been created'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
                ),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
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



