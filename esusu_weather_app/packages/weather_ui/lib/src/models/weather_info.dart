class WeatherInfo {
  double? latitude;
  double? longitude;
  double? generationtimeMs;
  int? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  int? elevation;
  CurrentUnits? currentUnits;
  Current? current;

  WeatherInfo(
      {this.latitude,
        this.longitude,
        this.generationtimeMs,
        this.utcOffsetSeconds,
        this.timezone,
        this.timezoneAbbreviation,
        this.elevation,
        this.currentUnits,
        this.current});

  WeatherInfo.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    generationtimeMs = json['generationtime_ms'];
    utcOffsetSeconds = json['utc_offset_seconds'];
    timezone = json['timezone'];
    timezoneAbbreviation = json['timezone_abbreviation'];
    elevation = json['elevation'];
    currentUnits = json['current_units'] != null
        ? new CurrentUnits.fromJson(json['current_units'])
        : null;
    current =
    json['current'] != null ? new Current.fromJson(json['current']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['generationtime_ms'] = this.generationtimeMs;
    data['utc_offset_seconds'] = this.utcOffsetSeconds;
    data['timezone'] = this.timezone;
    data['timezone_abbreviation'] = this.timezoneAbbreviation;
    data['elevation'] = this.elevation;
    if (this.currentUnits != null) {
      data['current_units'] = this.currentUnits!.toJson();
    }
    if (this.current != null) {
      data['current'] = this.current!.toJson();
    }
    return data;
  }
}

class CurrentUnits {
  String? time;
  String? interval;
  String? temperature2m;
  String? relativeHumidity2m;
  String? weatherCode;
  String? windSpeed10m;
  String? windDirection10m;
  String? windGusts10m;

  CurrentUnits(
      {this.time,
        this.interval,
        this.temperature2m,
        this.relativeHumidity2m,
        this.weatherCode,
        this.windSpeed10m,
        this.windDirection10m,
        this.windGusts10m});

  CurrentUnits.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    interval = json['interval'];
    temperature2m = json['temperature_2m'];
    relativeHumidity2m = json['relative_humidity_2m'];
    weatherCode = json['weather_code'];
    windSpeed10m = json['wind_speed_10m'];
    windDirection10m = json['wind_direction_10m'];
    windGusts10m = json['wind_gusts_10m'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['interval'] = this.interval;
    data['temperature_2m'] = this.temperature2m;
    data['relative_humidity_2m'] = this.relativeHumidity2m;
    data['weather_code'] = this.weatherCode;
    data['wind_speed_10m'] = this.windSpeed10m;
    data['wind_direction_10m'] = this.windDirection10m;
    data['wind_gusts_10m'] = this.windGusts10m;
    return data;
  }
}

class Current {
  String? time;
  int? interval;
  double? temperature2m;
  int? relativeHumidity2m;
  int? weatherCode;
  double? windSpeed10m;
  int? windDirection10m;
  double? windGusts10m;

  Current(
      {this.time,
        this.interval,
        this.temperature2m,
        this.relativeHumidity2m,
        this.weatherCode,
        this.windSpeed10m,
        this.windDirection10m,
        this.windGusts10m});

  Current.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    interval = json['interval'];
    temperature2m = json['temperature_2m'];
    relativeHumidity2m = json['relative_humidity_2m'];
    weatherCode = json['weather_code'];
    windSpeed10m = json['wind_speed_10m'];
    windDirection10m = json['wind_direction_10m'];
    windGusts10m = json['wind_gusts_10m'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['interval'] = this.interval;
    data['temperature_2m'] = this.temperature2m;
    data['relative_humidity_2m'] = this.relativeHumidity2m;
    data['weather_code'] = this.weatherCode;
    data['wind_speed_10m'] = this.windSpeed10m;
    data['wind_direction_10m'] = this.windDirection10m;
    data['wind_gusts_10m'] = this.windGusts10m;
    return data;
  }
}
