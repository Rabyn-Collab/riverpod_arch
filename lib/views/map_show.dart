import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  final Position position;
  const MapSample({super.key, required this.position});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
   Set<Marker> markers = {};
  @override
  void initState() {
    markers.add(Marker(
        markerId: MarkerId('id'),
      infoWindow: InfoWindow(title: 'MindRisers'),
      position: LatLng(widget.position.latitude, widget.position.longitude)
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: markers,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            bearing: 192.8334901395799,
            target: LatLng(widget.position.latitude, widget.position.longitude),
            tilt: 59.440717697143555,
            zoom: 19.151926040649414
        ),
        onMapCreated: (GoogleMapController controller) {
        },
      ),
    );
  }


}