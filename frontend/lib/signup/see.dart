import 'package:flutter/material.dart';
import 'package:innocart/main.dart';

class See extends StatefulWidget {
  See({Key? key, required this.onClick}) : super(key: key);
  Function onClick;
  @override
  State<See> createState() => SeeState();
}
class SeeState extends State<See> {
  bool see = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return IconButton(onPressed: (){
      setState((){
        super.widget.onClick();
        see = !see;
      });
    }, iconSize: 20,icon: Image.asset(see?"assets/images/see.png":"assets/images/nosee.png"));
  }
}
