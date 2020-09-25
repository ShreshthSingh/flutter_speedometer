import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import '../models/user_location.dart';
import 'dart:async';
import 'dart:math';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Timer timer;
  double prevLat;
  double prevLong;
  double currLong;
  double currLat;
  double speed;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (prevLat != null && prevLong != null) {
        var p = 0.017453292519943295;
        var c = cos;
        var a = 0.5 -
            c((currLat - prevLat) * p) / 2 +
            c(prevLat * p) *
                c(currLat * p) *
                (1 - c((currLong - prevLong) * p)) /
                2;
        print((12742 * asin(sqrt(a))) / 1.0);
        setState(() {
          speed = (12742 * asin(sqrt(a)) * 3600) / 1.0;
        });

        prevLat = currLat;
        prevLong = currLong;
      } else {
        prevLat = currLat;
        prevLong = currLong;
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    currLong = userLocation.longitude;
    currLat = userLocation.latitude;
    return Center(
      child: Text(
        'Location: Lat${userLocation?.latitude}, Long: ${userLocation?.longitude},Speed (km/hr):$speed',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      ),
    );
  }
}
