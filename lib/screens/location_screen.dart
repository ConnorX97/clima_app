import 'package:clima_app/screens/city_screen.dart';
import 'package:clima_app/services/weather.dart';
import 'package:clima_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  const LocationScreen({this.locationWeather});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late var temperature;
  late String cityName;
  late String weatherMessage;
  late String weatherIcon;

  @override
  void initState() {
    var AllWeatherData = widget.locationWeather;
    updateUI(AllWeatherData);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = "Xatolik";
        weatherIcon;
        weatherMessage = "Shahar nomi kiritilmadi yoki topilmadi";
        cityName = " ";
      } else {
        double temp = weatherData['main']['temp'];
        temperature = temp.toInt();

        var condition = weatherData['weather'][0]['id'];
        weatherIcon = weather.getWeatherIcon(condition);

        weatherMessage = weather.getMessage(condition);
        cityName = weatherData["name"];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFc9cddd),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async {
                        var weatherData = await weather.getLocationWeather();
                        updateUI(weatherData);
                      },
                      child: const Icon(
                        Icons.near_me,
                        size: 30.0,
                        color: Color(0xFF503c52),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CityScreen(),
                          ),
                        );
                        if (typedName != null) {
                          var weatherData =
                              await weather.getCityWeather(typedName);
                          updateUI(weatherData);
                        } else {
                          print("Error");
                        }
                      },
                      child: const Icon(
                        Icons.search,
                        size: 30.0,
                        color: Color(0xFF503c52),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    "$cityName",
                    textAlign: TextAlign.center,
                    style: kMessageTextStyle,
                  ),
                  Container(
                    height: 400,
                    child: Lottie.asset(weatherIcon),
                  ),
                  Text(
                    weatherMessage,
                    style: kMessageTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "$temperature°",
                    textAlign: TextAlign.center,
                    style: kTempTextStyle,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
