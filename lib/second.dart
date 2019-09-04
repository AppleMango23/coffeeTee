import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Code Snippets',
      theme: new ThemeData(primarySwatch: Colors.red),
      home: new TouchID(),
    );
  }
}

class TouchID extends StatefulWidget {
  @override
  _TouchIDState createState() => _TouchIDState();
}

class _TouchIDState extends State<TouchID> {
  final LocalAuthentication localAuth = LocalAuthentication();
  bool _canCheckBiometric = false;
  String _authorizeText = 'Not Authorized!';


  List<BiometricType> availableBiometrics = List<BiometricType>();

  Future<void> _authorize() async {
    var now = new DateTime.now();
    // var setNow;
    print(now);
    bool _isAuthorized = false;
    try {
      _isAuthorized = await localAuth.authenticateWithBiometrics(
        localizedReason: 'TEST to Complete this process',
        useErrorDialogs: false,
        stickyAuth: false,
      );

      // setNow = now.hour;
      
      // if(now.hour > setNow){
      //   print('fingerprint expired');
      // }

    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      if (_isAuthorized) {
        _authorizeText = "Authorized Successfully!";
      } else {
        _authorizeText = "Not Authorized!";
      }
    });
  }

  testingFunction(context){
    

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)),
          title: FlatButton.icon(
            color: Colors.transparent,
            icon: 
            new IconTheme(
                data: new IconThemeData(
                    size: 46,
                    color: Colors.red), 
                child: new Icon(Icons.error_outline),
            ),
            label: Text('Be caution!',style: TextStyle(color:Colors.black,fontSize: 23)), 
            onPressed: null,
          ),
          content: 
          new Text(
              "Be caution you will be deleting text . Please double confirm.",style: TextStyle(fontSize: 18),),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton.icon(
            color: Colors.teal,
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)),
            icon: 
            new IconTheme(
                data: new IconThemeData(
                    size: 23,
                    color: Colors.white), 
                child: new Icon(Icons.delete_outline),
            ),
            label: Text('Delete',style: TextStyle(color:Colors.white,fontSize: 20)), 
            // shape: RoundedRectangleBorder(
            // borderRadius: BorderRadius.circular(20)),
            onPressed: () {
                
                
              },

          ),

          ],
        );
      },
    );

    

    Timer(Duration(seconds: 9), () {
      print('heyy');
      // Scaffold.of(context).hideCurrentSnackBar();
      
    });
  }

  testingSaveFunction()async{
    var counter = 55;

    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // set value
    prefs.setInt('counter', counter);
    print('save');
  }

  testingReadFunction()async{
    final prefs = await SharedPreferences.getInstance();

    // Try reading data from the counter key. If it doesn't exist, return 0.
    final counter = prefs.getInt('counter');
    print(counter);
  }

  @override
  Widget build(BuildContext context) {
    // _TouchIDState();
    return Scaffold(
      appBar: AppBar(title: Text('Touch ID Auth Example')),
      
      body: Center(
      
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_authorizeText),
          ),
          RaisedButton(
            child: Text('Authorize'),
            color: Colors.red,
            onPressed: _authorize,
          ),
          Builder(
            builder: (context123) => 
            RaisedButton(
              child: Text('Press me'),
              color: Colors.red,
              onPressed: (){testingSaveFunction();},
            ),
          ),
          RaisedButton(
              child: Text('Show'),
              color: Colors.red,
              onPressed: (){testingReadFunction();},
            ),
        ],
      )),
    );
  }
}