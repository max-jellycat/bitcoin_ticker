import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bitcoin_ticker/utils/coin_data.dart';
import 'package:bitcoin_ticker/utils/constants.dart';
import 'package:bitcoin_ticker/widgets/box.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String selectedCurrency = currenciesList[0];

  void onCurrencyChanged(String currency) {
    setState(() {
      this.selectedCurrency = currency;
    });
  }

  DropdownButton<String> renderAndroidDropdown() {
    List<DropdownMenuItem<String>> items = [];

    for (String currency in currenciesList) {
      items.add(DropdownMenuItem<String>(
        child: Text(currency),
        value: currency,
      ));
    }

    return DropdownButton<String>(
      value: this.selectedCurrency,
      items: items,
      onChanged: (value) {
        setState(() {
          this.selectedCurrency = value;
        });
      },
    );
  }

  CupertinoPicker renderIOSPicker() {
    List<Text> items = [];

    for (String currency in currenciesList) {
      items.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: kPrimaryColor,
      itemExtent: 32.0,
      children: items,
      onSelectedItemChanged: (index) {
        setState(() {
          this.selectedCurrency = currenciesList[index];
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bitcoin Ticker",
          style: kAppBarTextStyle,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Box(
            color: kAccentColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '1 BTC = ? EUR',
                textAlign: TextAlign.center,
                style: kCardTextStyle,
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: kPrimaryColor,
            child: Platform.isIOS
                ? this.renderIOSPicker()
                : this.renderAndroidDropdown(),
          )
        ],
      ),
    );
  }
}
