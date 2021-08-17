import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weather/utilities/constant.dart';
import 'package:weather/utilities/openweatherdata.dart';
import 'package:weather/utilities/weatherbox.dart';
import 'package:weather/weather_data/weather_data.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<WeatherData> weatherData;
  @override
  void initState() {
    super.initState();
    log('initstate');
    weatherData = OpenWeatherData.fetchByPosition();
    // if (cityName != null) {
    //   weatherData = OpenWeatherData.fetchByName(cityName: cityName);
    // } else {
    //   weatherData = OpenWeatherData.fetchByPosition();
    // }
  }

  var cityName = "";
  Icon IconSearch = Icon(Icons.search);
  Widget NameApp = Text(
    'Weather',
    style: kTextStlye,
  );
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A67F2),
        title: TextButton(
          onPressed: () {
            weatherData = OpenWeatherData.fetchByPosition();
            setState(() {});
          },
          child: NameApp,
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                setState(() {
                  if (IconSearch.icon == Icons.search) {
                    IconSearch = Icon(Icons.cancel);
                    NameApp = TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        cityName = value;
                        if (cityName != null) {
                          weatherData = OpenWeatherData.fetchByName(cityName: cityName);
                        } else {
                          weatherData = OpenWeatherData.fetchByPosition();
                        }
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search City",
                      ),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    );
                  } else {
                    this.IconSearch = Icon(Icons.search);
                    this.NameApp = Text(
                      'Weather',
                      style: kTextStlye,
                    );
                  }
                });
              },
              icon: IconSearch),
          const Icon(
            Icons.more_vert,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
            Color(0xFF5A67F2),
            Color(0xFF8fb7f3),
            Color(0xfff38f8f),
            Color(0xffffc000),
          ]),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              FutureBuilder<WeatherData>(
                future: weatherData, // a previously-obtained Future<String> or null
                builder: (BuildContext context, AsyncSnapshot<WeatherData> snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    children = <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: kWhiteColor,
                              size: 25,
                            ),
                            Text(
                              ' ${snapshot.data!.name}',
                              style: const TextStyle(color: kWhiteColor, fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: kPaddingTop,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                                'http://openweathermap.org/img/wn/${snapshot.data!.weather!.first.icon}@2x.png'),
                            Text(
                              '${snapshot.data!.main!.temp}°',
                              style: const TextStyle(fontSize: 75, color: kWhiteColor),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${snapshot.data!.main!.tempMax}°', style: kTextStlye),
                            const Text(
                              '/',
                              style: kTextStlye,
                            ),
                            Text('${snapshot.data!.main!.tempMin}°', style: kTextStlye),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Feels Like${snapshot.data!.main!.feelsLike}°',
                              style: kTextStlye,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: kPaddingTop,
                        child: Center(
                          child: Text('${snapshot.data!.weather!.first.description}',
                              style: TextStyle(fontSize: 30, color: kWhiteColor)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: WeatherBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Icon(
                                    Icons.water,
                                    color: kWhiteColor,
                                    size: 50,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Humidity',
                                        style: kTextStlye,
                                      ),
                                      Text(
                                        '${snapshot.data!.main!.humidity} %',
                                        style: kTextStlye,
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                              Center(
                                child: Container(
                                  child: SizedBox(
                                    width: 1,
                                    height: 10,
                                  ),
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: kWhiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 5,
                                  height: 90,
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Icon(
                                    Icons.air,
                                    color: kWhiteColor,
                                    size: 50,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Wind',
                                        style: kTextStlye,
                                      ),
                                      Text(
                                        '${snapshot.data!.wind!.speed} m/s',
                                        style: kTextStlye,
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      )
                    ];
                  } else if (snapshot.hasError) {
                    children = <Widget>[
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: kTextStlye,
                        ),
                      )
                    ];
                  } else {
                    children = const <Widget>[
                      SizedBox(
                        child: CircularProgressIndicator(),
                        width: 60,
                        height: 60,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text(
                          'Awaiting result...',
                          style: kTextStlye,
                        ),
                      )
                    ];
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: children,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
