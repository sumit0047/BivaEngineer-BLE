import 'package:bivaengineer/screens/BTOffScreen.dart';
import 'package:bivaengineer/screens/Landing.dart';
import 'package:bivaengineer/screens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
        future: FirebaseAuth.instance.currentUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
          if (snapshot.hasData){
            FirebaseUser user = snapshot.data;
            return MaterialApp(
              home: StreamBuilder<BluetoothState>(
                  stream: FlutterBlue.instance.state,
                  initialData: BluetoothState.unknown,
                  builder: (c, snapshot) {
                    final state = snapshot.data;
                    if (state == BluetoothState.on) {
                      return Landing();
                    }
                    return OffScreen();
                  }),
            );
          }
          return MaterialApp(
            home: Login(),
          );
        }
    );
  }
}


