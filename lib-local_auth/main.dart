import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LocalAuthentication localAuth = LocalAuthentication();
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await localAuth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    setState(() => _canCheckBiometrics = canCheckBiometrics);
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await localAuth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    setState(() => _availableBiometrics = availableBiometrics);
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await localAuth.authenticateWithBiometrics(
        localizedReason: 'Scan your fingerprint to authenticate',
        useErrorDialogs: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }
    setState(() => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Local Auth proba'),
      ),
      body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Can check biometrics: $_canCheckBiometrics\n'),
                RaisedButton(
                  child: const Text('Check biometrics'),
                  onPressed: _checkBiometrics,
                ),
                Text('Available biometrics: $_availableBiometrics\n'),
                RaisedButton(
                  child: const Text('Get available biometrics'),
                  onPressed: _getAvailableBiometrics,
                ),
                Text('Current State: $_authorized\n'),
                RaisedButton(
                  child: const Text('Authenticate'),
                  onPressed: _authenticate,
                )
              ])),
    ));
  }
}
