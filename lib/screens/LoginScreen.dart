
import 'package:bivaengineer/api/SignIn.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


  @override
  void initState() {
    print("in login screen");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                //stops: [0.15,0.55],
                stops: [
                  0.1,
                  0.3,
                  0.5,
                  0.7,
                  0.9,
                  1
                ],
                colors: [
                  Color(0xff845ec2),
                  Color(0xffd65db1),
                  Color(0xffff6f91),
                  Color(0xffff9671),
                  Color(0xffffc75f),
                  Color(0xfff9f871)
                ])
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Center(
                        child: Container(
                            height:
                            MediaQuery.of(context).size.height * 0.15,
                            child: Image(
                              image: AssetImage('assets/images/logo.png'),
                              color: Colors.white54,
                            )),
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: Text("BivaEngineer"),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.white70,
      onPressed: () {
        signInWithGoogle().whenComplete(() {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return MyApp();
              },
            ),
          );
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.white70),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/images/google.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
