import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  final LatLng myLocation;
  const MapScreen({Key? key , required this.myLocation}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final mapController = MapController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: widget.myLocation,
        ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(
                markers: [
                  Marker(
                    point: widget.myLocation,
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                  ),
                ],
            ),
          ],
      ),
    );
  }
}
