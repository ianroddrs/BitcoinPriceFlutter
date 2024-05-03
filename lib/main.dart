import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PriceScreen(),
    ));

class PriceScreen extends StatefulWidget {
  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String _bitcoinPrize = "0.00";

  void _atualizarBitcoin() async {
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(url);

    Map<String, dynamic> retorno = json.decode(response.body);

    setState(() {
      _bitcoinPrize = retorno["BRL"]["last"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/img/bitcoin.png'),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Text(
                'R\$ $_bitcoinPrize',
                style: TextStyle(fontSize: 28),
              ),
            ),
            RaisedButton(
              color: Colors.orange,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Text(
                'Atualizar',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: _atualizarBitcoin,
            )
          ],
        ),
      ),
    );
  }
}
