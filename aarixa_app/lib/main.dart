import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';

void main() {
  // Widget 'MaterialApp()'
  runApp(MaterialApp(
    home: Scaffold(
        appBar: AppBar(
          title: Text('All Countries'),
          centerTitle: true,
        ),
        backgroundColor: Colors.blueGrey[100],
        body: HomeCountries()),
  ));
}

class HomeCountries extends StatefulWidget {
  @override
  _HomeCountriesState createState() => _HomeCountriesState();
}

class _HomeCountriesState extends State<HomeCountries> {
  //0. Define variables
  String url = 'https://restcountries.eu/rest/v2/all';
  List countries = [];

  // 1. Init my state
  void initState() {
    getCountries();
  }

  // 2. Get the countries from API
  getCountries() async {
    Response response = await get(url);

    if (response.statusCode == 200) {
      // yes
      List jsonResponse = jsonDecode(response.body);
      setState(() {
        countries = jsonResponse;
      });
    } else {
      // no, error
      setState(() {
        countries = [
          {'name': 'oH no! Error', 'capital': 'not found', 'flag': ''}
        ];
      });
    }
  }

  // *********************** UI

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
                itemCount: countries.length,
                padding: EdgeInsets.all(8.0),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: SvgPicture.network(
                      countries[index]['flag'],
                      width: 64,
                    ),
                    title: Text(countries[index]['name']),
                    subtitle: Text(countries[index]['capital']),
                  );
                }))
      ],
    );
  }
}
