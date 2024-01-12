import 'dart:io';
import 'package:awesome_place_search/awesome_place_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esusu_weather_app/landing/bloc/weather_info_cubit.dart';

class LandingBody extends StatefulWidget {
  const LandingBody({Key? key}) : super(key: key);

  @override
  State<LandingBody> createState() => _LandingBodyState();
}

class _LandingBodyState extends State<LandingBody> {
  PredictionModel? prediction;
  String locationName = '📍Current Location';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherInfoCubit>(
      key: const Key('landing_Body'),
      create: (context) => WeatherInfoCubit()..getPermission(),
      child: BlocBuilder<WeatherInfoCubit, WeatherInfoState>(
        builder: (context, state) {
          if (state is WeatherInfoInitial) {
            /// display loading indicator
            return Platform.isAndroid
                ? const Center(
                  heightFactor: 25,
                  child: CircularProgressIndicator(
                    color: Colors.white,),
                )
                : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: const CupertinoActivityIndicator(
                    color: Colors.white,
                    radius: 50,
                  ),
                );
          } else if (state is WeatherInfoLoaded) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child:  SafeArea(
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// location name
                          Text(locationName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight:
                                FontWeight.bold,
                              )
                          ),
                          const SizedBox(height: 40,),
                          /// Temperature
                          Text(state.info![0],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 80,fontWeight:
                              FontWeight.bold)),
                          const SizedBox(height:10,),
                          /// Conditions
                          Text(state.info![3],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25)),
                          const SizedBox(height: 40,),
                          /// icon representation of conditions
                          conditionPicker(state.info![3]),
                          const SizedBox(height: 40,),
                          /// relative humidity
                          Text('Humidity: ${state.info![1]}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25)),
                          const SizedBox(height: 10,),
                          /// Wind speed
                          Text('Wind speed: ${state.info![2]}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25)),
                          const SizedBox(height: 100,),

                          /// search feature
                          FloatingActionButton(
                            elevation: 10.0,
                            onPressed: () {
                              _searchPlaces(context);
                            },
                            child: const Icon(Icons.search,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ),
            );
          } else if (state is WeatherInfoError) {
            return const Column(
              children: [
                Icon(Icons.error),
                Text('An error has occurred. Please try again.')
              ],
            );
          }
          return const Column();
        },
      ),
    );

  }

  /// handles search with Maps API key
  void _searchPlaces(BuildContext context) async {
    AwesomePlaceSearch(
      context: context,
      key: "AIzaSyCUfcgcKK_vyTxiSHdRhLXjIFqrR5bsU0A",
      hint: 'Search location for current weather',//Insert Your google Api Key
      onTap: (value) async {
        final result = await value;
        setState(() {
          prediction = result;
          locationName = '📍 ${prediction!.description!}';
          context.read<WeatherInfoCubit>().grabWeatherInfo(prediction!.latitude, prediction!.longitude);
        });
      },
    ).show();
  }
}

/// return an appropriate icon for the current weather
Icon conditionPicker(dynamic weather){
  switch (weather) {
    case 'Clear sky':
      return const Icon(Icons.sunny, color: Colors.white, size: 100,);
      break;
    case 'Mainly clear':
      return const Icon(Icons.sunny, color: Colors.white, size: 100,);
      break;
    case 'Partly cloudy':
      return const Icon(Icons.wb_cloudy, color: Colors.white, size: 100,);
      break;
    case 'Overcast':
      return const Icon(Icons.wb_cloudy, color: Colors.white, size: 100,);
      break;
    case 'Fog':
      return const Icon(Icons.foggy, color: Colors.white, size: 100,);
      break;
    case 'Depositing rime fog':
      return const Icon(Icons.foggy, color: Colors.white, size: 100,);
      break;
    case 'Light drizzle':
      return const Icon(Icons.shower, color: Colors.white, size: 100,);
      break;
    case 'Moderate drizzle':
      return const Icon(Icons.shower, color: Colors.white, size: 100,);
      break;
    case 'Heavy drizzle':
      return const Icon(Icons.shower, color: Colors.white, size: 100,);
      break;
    case 'Light freezing drizzle':
      return const Icon(Icons.shower, color: Colors.white, size: 100,);
      break;
    case 'Heavy freezing drizzle':
      return const Icon(Icons.shower, color: Colors.white, size: 100,);
      break;
    case 'Slight rain':
      return const Icon(Icons.shower, color: Colors.white, size: 100,);
      break;
    case 'Moderate rain':
      return const Icon(Icons.shower, color: Colors.white, size: 100,);
      break;
    case 'Heavy rain':
      return const Icon(Icons.shower, color: Colors.white, size: 100,);
      break;
    case 'Light freezing rain':
      return const Icon(Icons.shower, color: Colors.white, size: 100,);
      break;
    case 'Heavy freezing rain':
      return const Icon(Icons.shower, color: Colors.white, size: 100,);
      break;
    case 'Slight snow fall':
      return const Icon(Icons.snowing, color: Colors.white, size: 100,);
      break;
    case 'Moderate snow fall':
      return const Icon(Icons.snowing, color: Colors.white, size: 100,);
      break;
    case 'Heavy snow fall':
      return const Icon(Icons.snowing, color: Colors.white, size: 100,);
      break;
    case 'Snow grains':
      return const Icon(Icons.snowing, color: Colors.white, size: 100,);
      break;
    case 'Slight rain showers':
      return const Icon(Icons.shower, color: Colors.white, size: 100,);
      break;
    case 'Moderate rain showers':
      return const Icon(Icons.shower, color: Colors.white, size: 100,);
      break;
    case 'Violent rain showers':
      return const Icon(Icons.shower, color: Colors.white, size: 100,);
      break;
    case 'Slight snow showers':
      return const Icon(Icons.shower, color: Colors.white, size: 100,);
      break;
    case 'Heavy snow showers':
      return const Icon(Icons.shower, color: Colors.white, size: 100,);
      break;
    case 'Thunderstorms':
      return const Icon(Icons.thunderstorm, color: Colors.white, size: 100,);
      break;
    case 'Thunderstorm with slight hail':
      return const Icon(Icons.thunderstorm, color: Colors.white, size: 100,);
      break;
    case 'Thunderstorm with heavy hail':
      return const Icon(Icons.thunderstorm, color: Colors.white, size: 100,);
      break;
  }
  return const Icon(Icons.sunny, color: Colors.white, size: 100,);
}
