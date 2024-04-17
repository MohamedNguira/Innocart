import 'package:flutter/material.dart';
import 'package:innocart/main.dart';

class Id extends StatefulWidget {
  Id({Key? key, required this.onClick}) : super(key: key);
  Function onClick;
  String content = "";
  @override
  State<Id> createState() => IdState();
}
class IdState extends State<Id> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double h = size.height,w = size.width;
    return SizedBox(height: 0.3 * h, width: 0.82 * w , child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              obscureText: false,
              onChanged: (String value) async{
                setState((){
                  super.widget.content = value;
                });
              },
              decoration: const InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Email or Phone Number',
              ),
            ),
            SizedBox(height: 10),
            Text('You will receive the verification code', textAlign: TextAlign.left, style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontFamily: 'Manjari',
                fontSize: 11,
                letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1
            ),)
            ,
            SizedBox(height: h * 0.1),
            TextButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(500,50)),
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
              onPressed: () { super.widget.onClick();},
              child: Text('Send Verification'),
            )
          ],
        )
      );
  }
}
