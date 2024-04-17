import 'package:flutter/material.dart';
import 'package:innocart/subscreens/angel.dart';
import 'package:innocart/subscreens/ordersinprogress.dart';
import '../homescreen.dart';
import '../network/changeorderstatus.dart';

import '../network/userservice.dart';
import 'order.dart';

class DeliveryStatus extends StatefulWidget {
  DeliveryStatus(this.call, {Key? key, required this.order}) : super(key: key);
  OrderBox order;
  Function call;
  @override
  State<StatefulWidget> createState() => DeliveryStatusState();
}

class DeliveryStatusState extends State<DeliveryStatus> {
  static late Function update;

  late User user;
  bool loaded = false;
  @override
  void initState() {
    user = User(0, "", "", "", 0, "", [], []);
    UserService().getUserProfile(() {
      setState(() {
        loaded = true;
      });
    }, widget.order.id, user);
  }

  @override
  Widget build(BuildContext context) {
    double h = HomeScreenState.height, w = HomeScreenState.width;
    Size size = MediaQuery.of(context).size;

    return Column(children: [

        TextButton(
            onPressed: () {
              OrdersInProgressState.state = "list";
              update();
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
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
            child: Icon(Icons.arrow_back)),
        SizedBox(
            width: w,
            child: Image.network(
                "https://assets-global.website-files.com/6050a76fa6a633d5d54ae714/609147088669907f652110b0_report-an-issue(about-maps).jpeg"))
      ,
      super.widget.order,
      Align(
          alignment: Alignment(-0.7, 0),
          child: Text("Pick up:" + widget.order.address+'\n' + widget.order.desc,
              style: const TextStyle(
                  fontFamily: 'Manjari',
                  fontWeight: FontWeight.normal,
                  fontSize: 24,
                  color: Colors.black))),
      TextButton(
          onPressed: () {
            OrdersInProgressState.state = "list";
            ChangeStatusService service = ChangeStatusService("2");
            service.put(widget.order.id);
            widget.call();
            update();
          },
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(Size(w * 0.9, 50)),
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
            ),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          child: Text('Confirm Order',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Manjari',
                  fontSize: 17,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 2)))
    ]);
  }
}
