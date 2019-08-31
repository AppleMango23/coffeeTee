import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    bool _isAuthorized = false;
    try {
      _isAuthorized = await localAuth.authenticateWithBiometrics(
        localizedReason: 'Please authenticate to Complete this process',
        useErrorDialogs: true,
        stickyAuth: true,
      );
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

  @override
  Widget build(BuildContext context) {
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
          )
        ],
      )),
    );
  }
}