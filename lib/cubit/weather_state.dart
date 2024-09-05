import 'package:equatable/equatable.dart';

class WeatherState extends Equatable {
  final String city;
  final double temperature;
  final String description;
  final bool isLoading;
  final bool hasError;

  const WeatherState({
    required this.city,
    required this.temperature,
    required this.description,
    this.isLoading = false,
    this.hasError = false,
  });

  factory WeatherState.initial() {
    return const WeatherState(
      city: '',
      temperature: 0.0,
      description: '',
      isLoading: false,
      hasError: false,
    );
  }

  @override
  List<Object?> get props => [city, temperature, description, isLoading, hasError];

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
