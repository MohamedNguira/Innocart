import 'dart:math';

import 'package:flutter/material.dart';
import 'package:innocart/homescreen.dart';
import 'package:innocart/login/reset/reset.dart';

import 'package:innocart/signup/signup.dart';
import 'package:innocart/login/login.dart';
import 'package:innocart/subscreens/mainprofile.dart';
import 'package:innocart/subscreens/orderview.dart';
import 'package:table_calendar/table_calendar.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  State<StatefulWidget> createState() => MainState();
}
enum AppState{
  SIGNUP,LOGIN,RESET,CONNECTED;
}

class MainState extends State<MyApp>{
  static AppState state = AppState.SIGNUP;
  static String uuid = "";
  @override
  Widget build(BuildContext context) {
    ProfileScreenState.signout = (){
      setState((){
          state = AppState.SIGNUP;
      });
    };
    late Widget current;
    if(state == AppState.SIGNUP){
      current = SignUpPage(title: "Signup",onTouched: (){
        setState((){

        });

      });
    }
    else if(state == AppState.LOGIN){
      current = LogInPage(title: "Login",onTouched: (){
        setState((){

        });

      }, onResetRequest: (){
        setState((){
          state = AppState.RESET;
        });
      });
    }
    else if(state == AppState.RESET){
      current = ResetPage(onClick: (){
        setState((){
          state = AppState.LOGIN;
        });

      });
    }else if(state == AppState.CONNECTED){
      current = HomeScreen();
    }

    return  MaterialApp(
      home: current
    );
  }

}



