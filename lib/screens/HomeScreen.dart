

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class HomeScreen extends StatefulWidget {


  final BluetoothDevice device;
  @override
  _HomeScreenState createState() => _HomeScreenState();

  HomeScreen(this.device);
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.name),
        actions: <Widget>[
          StreamBuilder<BluetoothDeviceState>(
            stream: widget.device.state,
            initialData: BluetoothDeviceState.connecting,
            builder: (c, snapshot) {
              VoidCallback onPressed;
              String text;
              switch (snapshot.data) {
                case BluetoothDeviceState.connected:
                  onPressed = () => widget.device.disconnect();
                  text = 'DISCONNECT';
                  break;
                case BluetoothDeviceState.disconnected:
                  onPressed = () => widget.device.connect();
                  text = 'CONNECT';
                  break;
                default:
                  onPressed = null;
                  text = snapshot.data.toString().substring(21).toUpperCase();
                  break;
              }
              return FlatButton(
                  onPressed: onPressed,
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .button
                        .copyWith(color: Colors.white),
                  ));
            },
          )
        ],
      ),
    body: Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height*0.02,
        ),
        Container(
          height: MediaQuery.of(context).size.height*0.5,
          color: Colors.blue,
        ),

        Container(height:MediaQuery.of(context).size.width*0.2,child: Center(child: RotatedBox(quarterTurns:2,child: Image(image: AssetImage('assets/images/arrow.png'))),)),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width*0.2,
            ),
            Container(height:MediaQuery.of(context).size.width*0.2,child: RotatedBox(quarterTurns:1,child: Image(image: AssetImage('assets/images/arrow.png'),))),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.2,
            ),
            Container(height:MediaQuery.of(context).size.width*0.2,child: RotatedBox(quarterTurns:3,child: Image(image: AssetImage('assets/images/arrow.png')))),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.2,
            ),
          ],
        ),
        Container(height:MediaQuery.of(context).size.width*0.2,child: Center(child: Image(image: AssetImage('assets/images/arrow.png')),)),
      ],
    ),
    );
  }
}
