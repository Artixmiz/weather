import 'dart:convert';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:weather/weather_data/weather_data.dart';
import 'package:http/http.dart' as http;
import 'constant.dart';

class OpenWeatherData {
  static Future<WeatherData> fetchByPosition() async {
    var location =
        await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low, forceAndroidLocationManager: true);
    log(location.toString());
    String lat = location.latitude.toStringAsFixed(3);
    String lon = location.longitude.toStringAsFixed(3);
    var url = 'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$kAPIKey&units=metric';
    return _fetch(uri: url);
  }

  static Future<WeatherData> fetchByName({required String cityName}) async {
    var url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$kAPIKey&units=metric';
    return _fetch(uri: url);
  }

  static Future<WeatherData> _fetch({required String uri}) async {
    var url = Uri.parse(uri);
    http.Response resp = await http.get(url);
    WeatherData weatherData;
    if (resp.statusCode == 200) {
      weatherData = WeatherData.fromJson(jsonDecode(resp.body));
      log(weatherData.toString());
    } else {
      log('error');
      throw Exception('Error');
    }
    return weatherData;
  }
}
