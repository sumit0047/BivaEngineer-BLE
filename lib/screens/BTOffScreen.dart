import 'package:flutter/material.dart';

class OffScreen extends StatefulWidget {
  @override
  _OffScreenState createState() => _OffScreenState();
}

class _OffScreenState extends State<OffScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(Icons.bluetooth_disabled,size: 150,),
      ),
    );
  }
}
