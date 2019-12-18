import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    home: HomePage(),
));

class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    String result = "Scan the Code";

  Future _scanQR() async{
    try{
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
      });
    }on PlatformException catch (ex){
      if(ex.code == BarcodeScanner.CameraAccessDenied){
        setState(() {
            result = "camera permission denied";          
        });
      }else{
        setState(() {
          result = "unknown error $ex";
        });
      }
    }on FormatException{
      setState(() {
        result = "you pressed the back button";
      });
    }catch (ex){
      setState(() {
        result = "unknown error $ex";
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
      ),
      body: Center(
        child: Text(result,
          style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Start Scanning"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}