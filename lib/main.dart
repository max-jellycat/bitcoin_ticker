import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/utils/constants.dart';
import 'package:bitcoin_ticker/screens/main_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitcoin Ticker',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kPrimaryColor,
      ),
      home: MainScreen(),
    );
  }
}
