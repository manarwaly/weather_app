import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/weather_cubit.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController cityController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Weather App',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: Colors.blue.shade100,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                fillColor: Colors.blue.shade500,
                filled: true,
                hintText: 'Enter City Name',
                hintStyle: const TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final city = cityController.text;
                if (city.isNotEmpty) {
                  context.read<WeatherCubit>().fetchWeather(city);
                }
              },
              child: const Text(
                'Get Weather',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, WeatherState state) {
                if (state.isLoading) {
                  return const CircularProgressIndicator();
                } else if (state.hasError) {
                  return const Text('Failed to fetch weather. Try again.');
                } else if (state.city.isNotEmpty) {
                  return Column(
                    children: [
                      Text(
                        'Weather in ${state.city}',
                        style: const TextStyle(fontSize: 24),
                      ),
                      Text(
                        '${state.temperature}°C',
                        style: const TextStyle(fontSize: 48),
                      ),
                      Text(
                        state.description,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  );
                } else {
                  return const Text('Enter a city to get weather information.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
