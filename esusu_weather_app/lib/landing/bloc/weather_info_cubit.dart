import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_repository/weather_repository.dart';
import 'package:geolocator/geolocator.dart';

part 'weather_info_state.dart';

/// local Global
bool locationGranted = false;

class WeatherInfoCubit extends Cubit<WeatherInfoState> {
  WeatherInfoCubit() : super(WeatherInfoInitial());

  List<dynamic>? info;

  /// Grab the weather info
  Future<void> grabWeatherInfo(dynamic lat, dynamic long) async {

    info = await WeatherRepository().grabInfo(lat, long);

    try {
      emit(WeatherInfoLoading());
      if (info != null) {
        emit(WeatherInfoLoaded(info!));
      }
    } catch (e) {
      emit(WeatherInfoError());
    }
  }

  /// prompt user for location access
  Future<void> getPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    /// if permission granted, grab current location
    if(permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      /// grabs weather from users current location
      grabWeatherInfo(null, null);
    }
  }
}

