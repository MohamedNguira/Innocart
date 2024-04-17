import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../homescreen.dart';
import '../network/userservice.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen(this.f, {Key? key}) : super(key: key);
  Function f;

  @override
  State<StatefulWidget> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  late User user;
  static late Function signout;
  bool loaded = false;
  @override
  void initState() {
    user = User(0, "", "", "", 0, "", [], []);
    UserService().getUserProfile(() {
      setState(() {
        loaded = true;
      });
    }, HomeScreenState.id, user);
  }

  @override
  Widget build(BuildContext context) {
    double h = HomeScreenState.height, w = HomeScreenState.width;
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        width: w * 0.9,
        height: h * 0.8,
        child: loaded
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    SizedBox(
                      //<-- SEE HERE
                      width: 200,
                      height: 200,
                      child: FittedBox(
                        //<-- SEE HERE
                        child: FloatingActionButton(
                          //<-- SEE HERE
                          backgroundColor: Colors.blue,

                          onPressed: () {},
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),SizedBox(height: 20),
                    Text(
                      user.name,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Manjari',
                          fontSize: 26,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.w500,
                          height: 1),
                    ),

                    RatingBar.builder(
                      itemSize: 20,
                      initialRating: double.parse(user.deliveryRate),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Color.fromRGBO(59, 66, 240, 1),

                      ),
                      onRatingUpdate: (rating) {},
                    ),
                    // Figma Flutter Generator RobertacklesWidget - TEXT
                    TextButton(
                      onPressed: () {},
                      child: Text("View Feedback", style: TextStyle(
                        color: Color.fromRGBO(59, 66, 240, 1),
                        fontFamily: 'Manjari',
                        fontSize: 16,
                        ),),
                    ),
                  SizedBox(height: 15),
                  Text("Delivered orders: " +
                      user.deliveredOrdersHistoryIds.length.toString(), style: TextStyle(
                    fontFamily: 'Manjari',
                    fontSize: 16,
                  ),),
                  Text("Email: " + user.email, style: TextStyle(
                    fontFamily: 'Manjari',
                    fontSize: 16,
                  ),),
                  Text("Phone Number: " + user.phoneNumber, style: TextStyle(
                    fontFamily: 'Manjari',
                    fontSize: 16,
                  ),),
                    SizedBox( height:20),
                    TextButton(
                      onPressed: () {},
                      child: Text("Change profile info"),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                                Size(0.42 * w, 0.03 * h)),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                Color c = HomeScreenState.angel
                                    ? Color.fromRGBO(194, 195, 211, 1)
                                    : Color.fromRGBO(59, 66, 240, 1);
                                if (states.contains(MaterialState.hovered))
                                  return c.withOpacity(0.7);
                                if (states.contains(MaterialState.focused) ||
                                    states.contains(MaterialState.pressed))
                                  return c.withOpacity(0.6);
                                return c; // Defer to the widget's default.
                              },
                            ),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          onPressed: () {
                            setState(() {
                              HomeScreenState.angel = false;
                              widget.f();
                            });
                          },
                          child: Text('Customer'),
                        ),
                        SizedBox(width: w * 0.03),
                        TextButton(
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                                Size(0.42 * w, 0.03 * h)),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                Color c = HomeScreenState.angel
                                    ? Color.fromRGBO(59, 66, 240, 1)
                                    : Color.fromRGBO(194, 195, 211, 1);
                                if (states.contains(MaterialState.hovered))
                                  return c.withOpacity(0.7);
                                if (states.contains(MaterialState.focused) ||
                                    states.contains(MaterialState.pressed))
                                  return c.withOpacity(0.6);
                                return c; // Defer to the widget's default.
                              },
                            ),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          onPressed: () {
                            setState(() {
                              HomeScreenState.angel = true;
                              widget.f();
                            });
                          },
                          child: Text('Angel'),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      style: ButtonStyle(
                        fixedSize:
                            MaterialStateProperty.all(Size(0.87 * w, 0.06 * h)),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
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
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          signout();
                        });
                      },
                      child: Text('Sign out'),
                    )
                  ])
            : Text("Loading"));
  }
}
