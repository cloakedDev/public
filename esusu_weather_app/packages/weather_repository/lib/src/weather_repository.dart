import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:weather_ui/weather_ui.dart';
import 'package:geolocator/geolocator.dart';

class WeatherRepository {
  WeatherRepository();

  /// grab info from the Weather API
  Future<List<dynamic>?> grabInfo(dynamic lat, dynamic long) async {

    WeatherInfo? info;
    List<dynamic> currentInfo = [];
    double latitude = 0.0;
    double longitude = 0.0;
    /// get location
    if(lat == null && long == null){
      /// grab current location
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
    } else {
      /// grab location from search
      latitude = lat;
      longitude = long;
    }

    int timeout = 5;
    try {
      http.Response response = await http
          .get(Uri.parse('https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current=temperature_2m,relative_humidity_2m,weather_code,wind_speed_10m,wind_direction_10m,wind_gusts_10m'))
          .timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        var jsonResponse =
        jsonDecode(response.body.toString()) as Map<String, dynamic>;
        /// Grab relevant info from the api and add to list
        currentInfo.add(jsonResponse['current']['temperature_2m'].toString() + jsonResponse['current_units']['temperature_2m'].toString());
        currentInfo.add(jsonResponse['current']['relative_humidity_2m'].toString() + jsonResponse['current_units']['relative_humidity_2m'].toString());
        currentInfo.add(jsonResponse['current']['wind_speed_10m'].toString() + jsonResponse['current_units']['wind_speed_10m'].toString());
        currentInfo.add(returnConditions(jsonResponse['current']['weather_code']));
        /// return list of weather info
        return currentInfo;
      } else {
        return null;
      }
    } on TimeoutException {
    } on SocketException {
    } on Error {}
    return null;
  }
}

/// convert weather code to it's description of conditions
String returnConditions(dynamic weatherCode){

  switch (weatherCode) {
    case 0:
      return 'Clear sky';
      break;
    case 1:
      return 'Mainly clear';
      break;
    case 2:
      return 'Partly cloudy';
      break;
    case 3:
      return 'Overcast';
      break;
    case 45:
      return 'Fog';
      break;
    case 48:
      return 'Depositing rime fog';
      break;
    case 51:
      return 'Light drizzle';
      break;
    case 53:
      return 'Moderate drizzle';
      break;
    case 55:
      return 'Heavy drizzle';
      break;
    case 56:
      return 'Light freezing drizzle';
      break;
    case 57:
      return 'Heavy freezing drizzle';
      break;
    case 61:
      return 'Slight rain';
      break;
    case 63:
      return 'Moderate rain';
      break;
    case 65:
      return 'Heavy rain';
      break;
    case 66:
      return 'Light freezing rain';
      break;
    case 67:
      return 'Heavy freezing rain';
      break;
    case 71:
      return 'Slight snow fall';
      break;
    case 73:
      return 'Moderate snow fall';
      break;
    case 75:
      return 'Heavy snow fall';
      break;
    case 77:
      return 'Snow grains';
      break;
    case 80:
      return 'Slight rain showers';
      break;
    case 81:
      return 'Moderate rain showers';
      break;
    case 82:
      return 'Violent rain showers';
      break;
    case 85:
      return 'Slight snow showers';
      break;
    case 86:
      return 'Heavy snow showers';
      break;
    case 95:
      return 'Thunderstorms';
      break;
    case 96:
      return 'Thunderstorm with slight hail';
      break;
    case 99:
      return 'Thunderstorm with heavy hail';
      break;
  }
  return '';
}
