import 'package:flutter/material.dart';
import 'package:innocart/login/reset/id.dart';
import 'package:innocart/login/reset/new.dart';
import 'package:innocart/login/reset/verif.dart';


class ResetPage extends StatefulWidget {
  ResetPage({Key? key, required this.onClick}) : super(key: key);
  Function onClick;
  String content = "";
  @override
  State<ResetPage> createState() => ResetPageState();
}
class ResetPageState extends State<ResetPage> {
  int step = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double h = size.height,w = size.width;
    return Scaffold(
        body: SingleChildScrollView(

    scrollDirection: Axis.vertical,
    child: Column (
        children: <Widget>[

    Container(
        width: w,
        height: h * 0.23,
        decoration: const BoxDecoration(
        color : Color.fromRGBO(137, 141, 247, 1),
    ),
    child: Image.asset("assets/images/logo.png")
    ),
    SizedBox(width: 0.8 * w,height: 0.65 * h,child: Column (
      crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
    const SizedBox(height: 20),
      Text('Reset password', textAlign: TextAlign.left, style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 1),
          fontFamily: 'Manjari',
          fontSize: 25,
          letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
          fontWeight: FontWeight.normal,
          height: 1
      ),),
      TextButton(
          onPressed: () {
        super.widget.onClick();
      }, child: Text("Back to Log in")),
      const SizedBox(height: 10),
      step == 0?Id(onClick: (){
        setState((){
          step++;
        });
      }) : step == 1? Verif(onClick: (){setState((){
        step++;
      });}):New(onClick: (){super.widget.onClick();})
    ]
    )
    )
    ])
    ));
  }
}
