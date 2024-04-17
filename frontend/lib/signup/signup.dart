import 'package:flutter/material.dart';
import 'package:innocart/homescreen.dart';
import 'package:innocart/main.dart';
import 'package:innocart/network/loginservice.dart';
import 'package:innocart/network/signupservice.dart';
import 'package:innocart/signup/see.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, required this.title, required this.onTouched}) : super(key: key);
  final Function onTouched;
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SignUpPage> createState() => _SignUpState();
}
class _SignUpState extends State<SignUpPage> {
  bool checked = false;
  bool customer = true;
  String email = "",password = "",name = "", phonenumber = "";
  bool showPassword = false;
  bool checkinfo = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height, width = size.width;
    Color buttonsColor1 = Color(0xffc3c3d3);
    Color buttonsColor2 = Color(0xff3b42f0);
    HomeScreenState.angel = !customer;
    Widget o = See(onClick: (){setState((){
      showPassword = ! showPassword;
      });
    });
    return Scaffold(

          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column (children: <Widget>[
                Container(
                    width: width,
                    height: height * 0.14,
                    decoration: const BoxDecoration(
                      color : Color.fromRGBO(137, 141, 247, 1),
                    ),
                    child: Image.asset("assets/images/logo.png")
                ),
                const SizedBox(height: 30),
                SizedBox(width: 0.87 * width,height: 0.58 * height,child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Sign up', textAlign: TextAlign.left, style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Manjari',
                        fontSize: 25,
                        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1
                    ),),
                    Row(children:  [
                      const Text('Already have an account?', textAlign: TextAlign.left, style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Manjari',
                          fontSize: 14,
                          letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.w300,
                          height: 1
                      ),),
                      SizedBox(height: 50, child: TextButton(onPressed: () {
                        MainState.state = AppState.LOGIN;
                        super.widget.onTouched();
                  }, child: Text("Log in" , textScaleFactor: 0.8,)))
                    ]),
                    SizedBox(height: height * 0.025),
                    Row(mainAxisAlignment: MainAxisAlignment.center , children: [
                      TextButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(0.42 * width,0.03 * height)),
                          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                                  Color current = customer?buttonsColor2:buttonsColor1;
                              if (states.contains(MaterialState.hovered))
                                return current.withOpacity(0.7);
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed))
                                return current.withOpacity(0.6);
                              return current; // Defer to the widget's default.
                            },
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () {
                          setState((){
                            customer = true;
                          });
                        },
                        child: Text('Customer'),
                      ),SizedBox(width: width * 0.03),
                      TextButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(0.42 * width,0.03 * height)),
                          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                                  Color current = customer?buttonsColor1:buttonsColor2;
                                  if (states.contains(MaterialState.hovered))
                                    return current.withOpacity(0.7);
                                  if (states.contains(MaterialState.focused) ||
                                      states.contains(MaterialState.pressed))
                                    return current.withOpacity(0.6);
                                  return current; // Defer to the widget's default.
                                },
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () {
                          setState((){
                            customer = false;
                          });
                        },
                        child: Text('Angel'),
                      )
                    ],),
                    SizedBox(height:20),
                    TextField(
                      obscureText: false,

                      onChanged: (String value) async{

                        setState((){
                          name = value;
                        });
                      },
                      decoration: const InputDecoration(

                        border: const OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                    ),SizedBox(height:20),
                    TextField(
                      obscureText: false,
                      onChanged: (String value) async{

                        setState((){
                          email = value;
                        });
                      },
                      decoration:const InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),SizedBox(height:20),
                    TextField(
                      obscureText:false,
                      onChanged: (String value) async{

                        setState((){
                          phonenumber = value;
                        });
                      },
                      decoration: const InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Phone Number',
                      ),
                    ),SizedBox(height:20),
                    TextField(

                      obscureText: !showPassword,
                      onChanged: (String value) async{

                        setState((){
                          password = value;
                        });
                      },
                      decoration: InputDecoration(
                        suffixIcon: o,
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    )])),
                    Row(crossAxisAlignment: CrossAxisAlignment.center,

                        children: [SizedBox(width: width * 0.035) ,Checkbox(
                      checkColor: Colors.white,
                      value: checked,
                      onChanged: (bool? value) {
                        setState(() {
                          checked = value!;
                        });
                      },
                    ),
                      const Text('I agree on the terms of use', textAlign: TextAlign.left, style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Manjari',
                          fontSize: 14,
                          letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1
                      ),)])
                    ,SizedBox(height:30),
                    Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                      TextButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(width * 0.87,50)),
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
                        onPressed: () {
                          bool valid = true;
                          if(checkinfo) {
                            if (!RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(email)) valid = false;
                            if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(
                                phonenumber)) valid = false;
                            // if(!RegExp(r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[*.!@$%^&(){}[]:;<>,.?/~_+-=|\]).{8,32}$').hasMatch(password))valid = false;
                          }
                          Signupservice service = Signupservice(password,name,phonenumber,email,20,4.5,widget.onTouched);
                          service.post();
                      if(valid == false)showAlertDialog(context,"Please verify your information");

                        },
                        child: Text('Sign up', textScaleFactor: 1.2,),
                      )
                    ],)

                  ])

                )


    );
  }
  showAlertDialog(BuildContext context, String msg) {
    // Create button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("An Error has occured"),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
