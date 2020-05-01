import 'dart:convert';

import 'package:bitcoin_ticker/networking_dart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  static const kCoinApiKey = 'A59BC367-E665-40A9-B97F-34C925FE1D9B';
  static int inrIndex = currenciesList.indexOf('INR');
  static String selectedCurrency = currenciesList[inrIndex];
  String btcValue = '';
  String ethValue = '';
  String ltcValue = '';
  @override
  Widget build(BuildContext context) {
    bool iosOrAndroid = Platform.isAndroid;
    print('${Platform.operatingSystem} and $iosOrAndroid');
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $btcValue $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH =  $ethValue $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $ltcValue $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? getAndroidDropDown() : iOSPicker(),
          ),
        ],
      ),
    );
  }

  Future getCurrencyDataFromNetwork(
      String cryptoType, CryptoCurrency cryptoCurrency) async {
    print(
        'https://rest.coinapi.io/v1/exchangerate/$cryptoType/$selectedCurrency?apikey=$kCoinApiKey');
    var data = await NetworkHelper(
            url:
                'https://rest.coinapi.io/v1/exchangerate/$cryptoType/$selectedCurrency?apikey=$kCoinApiKey')
        .getExchangeRate();
    updateUI(data, cryptoCurrency);
  }

  DropdownButton<String> getAndroidDropDown() {
    List<DropdownMenuItem<String>> menuItems = [];
    for (String currency in currenciesList) {
      menuItems.add(
        DropdownMenuItem(
          value: currency,
          child: Text(currency),
        ),
      );
    }
    return DropdownButton<String>(
      items: menuItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getCurrencyDataFromNetwork('BTC', CryptoCurrency.BTC);
          getCurrencyDataFromNetwork('ETH', CryptoCurrency.ETH);
          getCurrencyDataFromNetwork('LTC', CryptoCurrency.LTC);
        });
      },
      value: selectedCurrency,
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> items = [];
    for (String currency in currenciesList) {
      items.add(
        Text(
          currency,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
    return CupertinoPicker(
      itemExtent: 40.0,
      onSelectedItemChanged: (position) {
        setState(() {
          selectedCurrency = currenciesList[position];
          getCurrencyDataFromNetwork('BTC', CryptoCurrency.BTC);
          getCurrencyDataFromNetwork('ETH', CryptoCurrency.ETH);
          getCurrencyDataFromNetwork('LTC', CryptoCurrency.LTC);
        });
      },
      children: items,
      backgroundColor: Colors.lightBlue,
    );
  }

  void updateUI(String data, CryptoCurrency cryptoCurrency) {
    setState(() {
      var response = jsonDecode(data);
      var rate = response['rate'];
      if (cryptoCurrency == CryptoCurrency.BTC) {
        btcValue = rate.toStringAsFixed(2);
      } else if (cryptoCurrency == CryptoCurrency.ETH) {
        ethValue = rate.toStringAsFixed(2);
      } else {
        ltcValue = rate.toStringAsFixed(2);
      }
    });
  }
}

class ReusableGestureDetector extends StatelessWidget {
  final CryptoCurrency cryptoCurrency;
  final String currencyType;
  final Function onClick;
  final String selectedCurrency;

  ReusableGestureDetector(
      {this.cryptoCurrency,
      this.currencyType,
      this.onClick,
      this.selectedCurrency});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: GestureDetector(
        onTap: onClick,
        child: Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 $currencyType =  $selectedCurrency',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum CryptoCurrency { BTC, ETH, LTC }
