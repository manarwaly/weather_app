import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

// Weather State
class WeatherState {
  final String city;
  final double temperature;
  final String description;
  final bool isLoading;
  final bool hasError;

  WeatherState({
    this.city = '',
    this.temperature = 0.0,
    this.description = '',
    this.isLoading = false,
    this.hasError = false,
  });

  WeatherState copyWith({
    String? city,
    double? temperature,
    String? description,
    bool? isLoading,
    bool? hasError,
  }) {
    return WeatherState(
      city: city ?? this.city,
      temperature: temperature ?? this.temperature,
      description: description ?? this.description,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}

// Weather Cubit
class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherState());

  Future<void> fetchWeather(String city) async {
    emit(state.copyWith(isLoading: true, hasError: false));
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=893dad4e6cf76078ec6e1e2d72bfc280&units=metric'));
      if (response.statusCode == 200) {
        final weatherData = json.decode(response.body);
        final temp = weatherData['main']['temp'].toDouble();
        final description = weatherData['weather'][0]['description'];
        emit(state.copyWith(
          city: city,
          temperature: temp,
          description: description,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(isLoading: false, hasError: true));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }
}
