import 'package:dio/dio.dart';
import 'package:location/location.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

import '../../src/models/weather_forcast.dart';
import '../../widgets/toast.dart';

class DashboardViewModel extends BaseViewModel {
  final controls = _Controls();

  // List<IntradayScreenerData> intraday_data = [];
  // List<IntradayScreenerData> intradayOpenHigh = [];
  WeatherForcast? weatherData;
  Daily? currentUnits;
  bool showTimestampLoader = false;

  // bool onClick = false;
  // bool onSecondClick = false;
  // bool onthirdClick = false;
  // bool onfourthClick = false;
  final location = new Location();
  LocationData? currentLocation;

  late final FormGroup form;
  String customerId = "";

  DashboardViewModel() {
    form = FormGroup({
      controls.city: FormControl<String>(validators: [Validators.required]),
    });
    getWeatherAPI();
    weatherData;
    // getIntradayData();
    // getIntradayAPI();
    // initSetup();
  }

  void initSetup() async {}

  checkWeatherCode(String code) {
    switch (code) {
      case "0":
        return "Clear sky";
      case "77":
        return "Snow grains";
      case "95":
        return "Thunderstorm: Slight or moderate";
      case "1":
      case "2":
      case "3":
        return "Mainly clear, partly cloudy, and overcast";
      case "45":
      case "48":
        return "Fog and depositing rime fog";
      case "51":
      case "53":
      case "55":
        return "Drizzle: Light, moderate, and dense intensity";
      case "56":
      case "57":
        return "	Freezing Drizzle: Light and dense intensity";
      case "61":
      case "63":
      case "65":
        return "Rain: Slight, moderate and heavy intensity";
      case "66":
      case "67":
        return "	Freezing Rain: Light and heavy intensity";
      case "71":
      case "73":
      case "75":
        return "Snow fall: Slight, moderate, and heavy intensity";
      case "80":
      case "81":
      case "82":
        return "Rain showers: Slight, moderate, and violent";
      case "85":
      case "86":
        return "Snow showers slight and heavy";
      case "96":
      case "99":
        return "Thunderstorm with slight and heavy hail";
    }
  }

  Future<Map<String, double>?> getStartLocation() async {
    Map<String, double>? startLocation = <String, double>{};
    try {
      // showTimestampLoader = true;
      // notifyListeners();
      currentLocation = await location.getLocation();
      print(
          ' longitude -- ${currentLocation!.longitude} ***, latitude --${currentLocation!.latitude}');
      print(
          " Printing Start Location ---- ${currentLocation!.longitude} -- ${currentLocation!.latitude}");
      getWeatherAPI();
    } catch (e) {
      startLocation = null;
    }
    // showTimestampLoader = false;
    // notifyListeners();
    return startLocation;
  }

  // Future<void> getWeatherAPI() async {
  //   if (currentLocation!.latitude != null &&
  //       currentLocation!.longitude != null) {
  //     Response response = await Dio().get(
  //         'https://geocoding-api.open-meteo.com/v1/search?name=${}&count=10&language=en&format=json');
  //     // final List<WeatherForcast>? responsedata = response.data;
  //     if(response.data != null) {
  //       weatherData = WeatherForcast.fromJson(response.data);
  //       if(weatherData != null) {
  //         currentUnits = weatherData!.currentUnits!;
  //       }
  //       return;
  //     }
  //     // return responsedata;
  //   } else {
  //     Toast.show("Please Select Location");
  //   }
  // }
  Future<void> getWeatherAPI() async {
    if (currentLocation!.latitude != null &&
        currentLocation!.longitude != null) {
      Response response = await Dio().get(
          'https://api.open-meteo.com/v1/forecast?latitude=${currentLocation!.latitude}&longitude=${currentLocation!.longitude}&current=temperature_2m&daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset&timezone=auto&past_days=3');
      // final List<WeatherForcast>? responsedata = response.data;
      if (response.data != null) {
        weatherData = WeatherForcast.fromJson(response.data);
        print("printing ${weatherData!.daily}");
        // if(weatherData != null) {
        //   currentUnits = weatherData!.daily!;
        // }
        notifyListeners();
      }
      // return responsedata;
    } else {
      Toast.show("Please Select Location");
    }
  }

  Future<void> getWeatherAPIByCity() async {
    if (form.valid) {
      Response response = await Dio().get(
          'https://geocoding-api.open-meteo.com/v1/search?name=${form.control(controls.city).value}&count=10&language=en&format=json');
      // final List<WeatherForcast>? responsedata = response.data;
      if (response.data != null) {
        weatherData = WeatherForcast.fromJson(response.data);
        print("printing ${weatherData!.daily}");
        // if(weatherData != null) {
        //   currentUnits = weatherData!.daily!;
        // }
        notifyListeners();
      }
      // return responsedata;
    } else {
      Toast.show("Please Select Location");
    }
  }
}

class _Controls {
  String get city => 'city';
// String get loan_amount => 'loan_amount';
}
