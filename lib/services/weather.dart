import 'package:clima_app/services/location.dart';
import 'package:clima_app/services/networking.dart';
import 'package:lottie/lottie.dart';

const apiKey = '37bf7f0406119357fc510e0a37e31bcd';
const openWeatherMapURL = "https://api.openweathermap.org/data/2.5/weather";

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper =
        NetworkHelper("$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric");

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longtitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return "assets/thunder.json";
    } else if (condition < 400) {
      return "assets/rain.json";
    } else if (condition < 600) {
      return "assets/lightRain.json";
    } else if (condition < 700) {
      return "assets/snow.json";
    } else if (condition < 800) {
      return "assets/mist.json";
    } else if (condition == 800) {
      return "assets/sun.json";
    } else if (condition <= 804) {
      return "assets/cloud.json";
    } else {
      return '🤷‍';
    }
  }

  String getMessage(condition) {
    if (condition < 300) {
      return "Chaqmoq";
    } else if (condition < 400) {
      return "Yomg'ir";
    } else if (condition < 600) {
      return "Yengil yomg'ir";
    } else if (condition < 700) {
      return "Qor";
    } else if (condition < 800) {
      return "Tuman";
    } else if (condition == 800) {
      return "Ochiq";
    } else if (condition <= 804) {
      return "Bulut";
    } else {
      return '🤷‍';
    }
  }
}
