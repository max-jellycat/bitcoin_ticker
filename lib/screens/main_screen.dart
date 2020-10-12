import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bitcoin_ticker/utils/coin_data.dart';
import 'package:bitcoin_ticker/utils/constants.dart';
import 'package:bitcoin_ticker/widgets/box.dart';
import 'package:bitcoin_ticker/services/rates.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String selectedCurrency = currenciesList[0];
  List<dynamic> data;

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  void getData() async {
    RatesService rateService = RatesService();
    List<dynamic> data = await rateService.getRates(this.selectedCurrency);

    this.updateUI(data);
  }

  void updateUI(data) {
    setState(() {
      this.data = data;
    });
  }

  List<Widget> renderBoxes() {
    List<Widget> items = [];
    for (dynamic item in this.data) {
      items.add(Box(
        color: kAccentColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '1 ${item["key"]} = ${item["rate"]} ${this.selectedCurrency}',
            textAlign: TextAlign.center,
            style: kCardTextStyle,
          ),
        ),
      ));
    }

    return items;
  }

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
          this.getData();
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
          this.getData();
        });
      },
    );
  }

  Widget renderLoader() {
    return Center(
      child: CupertinoActivityIndicator(
        animating: true,
      ),
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
      body: this.data != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: this.renderBoxes(),
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
            )
          : this.renderLoader(),
    );
  }
}
