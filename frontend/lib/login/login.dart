import 'package:flutter/material.dart';
import 'package:innocart/network/loginservice.dart';

import '../main.dart';


class LogInPage extends StatefulWidget {
  const LogInPage({Key? key, required this.title, required this.onTouched, required this.onResetRequest}) : super(key: key);
  final Function onTouched;
  final Function onResetRequest;
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<LogInPage> createState() => _LogInState();
}
class _LogInState extends State<LogInPage> {
  bool checked = false;
  String id = "", password = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height, width = size.width;

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
              SizedBox(height: height * 0.14),
              SizedBox(width: 0.8 * width,height: 0.65 * height,child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text('Log in', textAlign: TextAlign.left, style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontFamily: 'Manjari',
                      fontSize: 25,
                      letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1
                  ),),
                  Row(children:  [
                    const Text('Do not have an account?', textAlign: TextAlign.left, style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Manjari',
                        fontSize: 14,
                        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1
                    ),),
                    TextButton(onPressed: () {
                      super.widget.onTouched();
                      MainState.state = AppState.SIGNUP;
                    }, child: Text("Sign up"))
                  ]),
                  TextField(
                    obscureText: false,
                    onChanged: (String value) async{

                      setState((){
                        id = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Email or Phone Number',
                    ),
                  ),SizedBox(height:20),
                  TextField(
                    obscureText: true,
                    onChanged: (String value) async{

                      setState((){
                        password = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),SizedBox(height:10),


                  TextButton(onPressed: () {
                    super.widget.onResetRequest();
                  }, child: Text("Forgot your password?")),
                  SizedBox(height:40),
                  Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                    TextButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(width * 0.8,height * 0.06)),
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
                          Loginservice loginService = Loginservice(id, password,super.widget.onTouched);
                          loginService.post();
                          // if(loginService.valid){
                          //   MainState.state = AppState.CONNECTED;
                          //   super.widget.onTouched();
                          // }
                      },
                      child: Text('Log in'),
                    )
                  ],)
                  ,

                ],


              )
                ,)
              ,

            ]
            ))

    );
  }
}
