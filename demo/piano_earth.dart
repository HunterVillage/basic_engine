import 'dart:convert';
import 'dart:math';

import 'package:basic_engine/bundle/piano.dart';
import 'package:basic_engine/constant/icon_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_earth/flutter_earth.dart';

class PianoEarth extends StatelessPiano {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Hero(tag: id, child: leading),
        title: Text('earth'),
      ),
      body: Earth(),
    );
  }

  @override
  Widget get leading => Icon(MyIcons.browser, color: Colors.green[400]);

  @override
  String get id => 'earth';

  @override
  int get sort => 1;

  @override
  String get cnName => '地图';
}

class Earth extends StatefulWidget {
  Earth({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EarthState createState() => _EarthState();
}

class _EarthState extends State<Earth> {
  FlutterEarthController _controller;
  double _zoom = 0;
  LatLon _position = LatLon(0, 0);
  String _cityName = '';
  dynamic _cityList;
  Random _random = Random();

  void _onMapCreated(FlutterEarthController controller) {
    _controller = controller;
    _moveToNextCity();
  }

  void _onCameraMove(LatLon latLon, double zoom) {
    setState(() {
      _zoom = zoom;
      _position = latLon.inDegrees();
    });
  }

  void _moveToNextCity() {
    if (_cityList != null) {
      final int index = _random.nextInt(_cityList.length);
      final dynamic city = _cityList[index];
      final double lat = double.parse(city['latitude']);
      final double lon = double.parse(city['longitude']);
      _cityName = city['city'];
      _controller.animateCamera(newLatLon: LatLon(lat, lon).inRadians(), riseZoom: 2.2, fallZoom: 11.2, panSpeed: 500, riseSpeed: 3, fallSpeed: 2);
    }
  }

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/city.json').then((String data) {
      _cityList = json.decode(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: FlutterEarth(
                    url: 'http://mt0.google.cn/vt/lyrs=y&hl=en&x={x}&y={y}&z={z}',
                    radius: 180,
                    onMapCreated: _onMapCreated,
                    onCameraMove: _onCameraMove,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Center(
                  child: Text(
                    'lat:${_position.latitude.toStringAsFixed(2)} lon:${_position.longitude.toStringAsFixed(2)} zoom:${_zoom.toStringAsFixed(2)}',
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(_cityName),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _moveToNextCity,
        tooltip: 'Increment',
        mini: true,
        child: Icon(Icons.location_searching),
      ),
    );
  }
}
