import 'package:bivaengineer/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {

  @override
  void initState() {
    FlutterBlue.instance
        .startScan(timeout: Duration(seconds: 3));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Devices'),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBlue.instance.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () => FlutterBlue.instance.stopScan(),
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
                child: Icon(Icons.search),
                onPressed: () => FlutterBlue.instance
                    .startScan(timeout: Duration(seconds: 5)));
          }
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.02,
              ),
              StreamBuilder<List<ScanResult>>(
                stream: FlutterBlue.instance.scanResults,
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data
                      .map(
                        (r) => Container(
                          child: Row(
                            children: [
                              Container(width: MediaQuery.of(context).size.width*0.12,child: Align(alignment:Alignment.centerRight,child: Text(r.rssi.toString()))),
                              Container(
                                width: MediaQuery.of(context).size.width*0.55,
                                child: Column(
                                  children: [
                                    Text(r.device.name.length>0?r.device.name:"Unknown Device",style: TextStyle(fontSize: 18),),
                                    Text(r.device.id.toString())
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.3,
                                child: RaisedButton(
                                  child: Text('CONNECT'),
                                  color: Colors.black,
                                  textColor: Colors.white,
                                  onPressed: (r.advertisementData.connectable) ? ()=>{
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(builder: (context) {
                                      r.device.connect();
                                      return HomeScreen(r.device);
                                      })),
                                  }: null,
                                ),
                              ),

                            ],
                          ),
                    ),
                  )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
