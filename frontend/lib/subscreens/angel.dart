import 'package:flutter/material.dart';
import 'package:innocart/homescreen.dart';

class AngelBox extends StatefulWidget {
  AngelBox({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AngelBoxState();
}

class Angel {
  String name;
  late Image picture;
  double rating;

  Angel(this.name, String imgurl, this.rating) {
    picture = Image.network(imgurl);
  }
}

class AngelBoxState extends State<AngelBox> {
  late Angel angel;
  Color buttonsColor2 = Color(0xff3b42f0);
  @override
  void initState() {
    angel = Angel(
        "Robert Ackles",
        "https://www.mantruckandbus.com/fileadmin/_processed_/7/1/csm_Richard_von_Braunschweig_4e4e3bd591.jpeg",
        4.6);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double h = HomeScreenState.height, w = HomeScreenState.width;

    return TextButton(
        onPressed: () {},
        child: Stack(children: [
          Container(
              width: 0.9 * w,
              height: h * 0.16,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 4,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              )),
          Positioned(
              left: 10,
              top: 15,
              child: SizedBox(height: 100, width: 100, child: angel.picture)),
          Positioned(
              left: 150,
              top: 12,
              child: Text(
                angel.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Manrope',
                    fontSize: 24,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          Positioned(
              left: 150,
              top: 50,
              child: Text(
                "Rating: " + angel.rating.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(150, 150, 0, 1),
                    fontFamily: 'Manjari',
                    fontSize: 16,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          Positioned(
              left: 240,
              top: 70,
              child: TextButton(
                child: Text("Choose"),
                  style: ButtonStyle(
                    fixedSize:
                        MaterialStateProperty.all(Size(100, 30)),
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        Color current = buttonsColor2;
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
                  onPressed: () {}))
        ]));
  }
}
