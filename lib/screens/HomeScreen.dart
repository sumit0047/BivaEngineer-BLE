

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
          height: MediaQuery.of(context).size.height*0.04,
        ),
        Center(
          child: Text("BIVA ENGINEER",style: TextStyle(fontSize: 31,letterSpacing: 1,fontWeight: FontWeight.bold),),
        ),
        Center(
          child: Text("INDIA OPC PVT LTD",style: TextStyle(fontSize: 19,letterSpacing: 1),),
        ),
        Center(
          child: Text("NEW DELHI",style: TextStyle(fontSize: 19,letterSpacing: 1),),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*0.05,
        ),
        StreamBuilder<BluetoothDeviceState>(
          stream: widget.device.state,
          initialData: BluetoothDeviceState.connecting,
          builder: (c, snapshot) => Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.05,
                  ),
                  Text("Device Status :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,letterSpacing: 0.5),),
                  Text("   "+snapshot.data.toString().split('.')[1],style: TextStyle(fontSize: 16,color: snapshot.data.toString().split('.')[1]=="connected"?Colors.green:Colors.blue,fontWeight: FontWeight.bold),)
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.02,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.05,
                  ),
                  Text("Device UUID :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,letterSpacing: 0.5),),
                  Text("   "+widget.device.id.toString(),style: TextStyle(fontSize: 16),)
                ],
              ),
            ],
          ),
        ),
        ],
    ),
    );
  }
}
