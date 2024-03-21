import 'dart:convert';
import 'package:clima_app/services/location.dart';
import 'package:clima_app/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

const apiKey = '37bf7f0406119357fc510e0a37e31bcd';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;

  void initState() {
    super.initState();
    getLocationData();
  }

  getLocationData() async {
    Location location = Location();
    await location.getLocation();
    latitude = location.latitude;
    longitude = location.longtitude;

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

    var weatherData = await networkHelper.getData();
    print(weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            getLocationData();
            //Get the current location
          },
          child: const Text('Get Location'),
        ),
      ),
    );
  }
}
