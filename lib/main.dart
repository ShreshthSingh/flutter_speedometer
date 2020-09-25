import 'package:flutter/material.dart';
//import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import './models/user_location.dart';
import './services/location_services.dart';
import './homeview/homeview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
      create: (context) => LocationService().locationStream,
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
            body: HomeView(),
          )),
    );
  }
}
