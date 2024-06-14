import 'dart:convert';
import '../models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class WeatherService {
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/forecast';
  final String apiKey;
  WeatherService(this.apiKey);
  Future<Weather> getWeather(String cityName) async{
    print('city: $cityName');
    final response = await http.get(Uri.parse('$BASE_URL?q=London&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }

  }
  Future<String> getCurrentCity() async{
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    // получить текущую позицию
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
      // преобразовать местоположение в список объектов-меток
      List<Placemark> placemarks = 
      await placemarkFromCoordinates(position.latitude, position.longitude);
      // извлечь название города из первой метки
      String? city = placemarks[0].locality;
      return city ?? "";
  }
}
