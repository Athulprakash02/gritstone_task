import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
Map<String, dynamic> weatherData = {};
class WeatherService {
  
   String apiKey = '5236a3feafc1478c80e143119233006';
  String searchWeatherAPI =
      "http://api.weatherapi.com/v1/forecast.json?key=5236a3feafc1478c80e143119233006&days=7&q=";
  Future<Map<String,dynamic>> fetchWeatherData() async {
  final Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        
        // Fetch placemarks
        final List<Placemark> placemarks =
            await placemarkFromCoordinates(position.latitude, position.longitude);
    try {
      var searchResult =
          await http.get(Uri.parse(searchWeatherAPI+placemarks.first.locality!));

       weatherData = Map<String, dynamic>.from(
          json.decode(searchResult.body) ?? 'No data');

     return weatherData;
    } catch (e) {
      return weatherData;
    }
  }
}
