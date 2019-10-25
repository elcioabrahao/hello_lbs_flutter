import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'city.dart';


class MapScreen extends StatefulWidget {

  final List<City> cities;

  MapScreen(this.cities);

  @override
  State<MapScreen> createState() => MapState();



}

class MapState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kfiap = CameraPosition(
    target: LatLng(-23.595439, -46.685302),
    zoom: 5,
  );

  Set<Marker> citiesMarkers = Set();

  @override
  void initState() {
    for (City city in widget.cities){
      citiesMarkers.add(
          Marker(
            markerId: MarkerId(city.name),
            position: LatLng(
              city.latitude,
              city.longitude,
            ),
            infoWindow: InfoWindow(
                title: city.name,
                snippet: city.state),
          ));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kfiap,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: citiesMarkers,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.school),
      ),
    );
  }

}
