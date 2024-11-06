import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:it_sharks_first_app/shared/cubit/app_cubit/app_cubit.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  final LatLng myLocation;

  const MapScreen({super.key, required this.myLocation});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final mapController = MapController();
  late LatLng currentLocation;

  @override
  void initState() {
    super.initState();
    currentLocation = widget.myLocation;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if(state is GetAddressSuccessfully || state is GetAddressWithError){
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Expanded(
                child: Scaffold(
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.my_location_outlined,
                    ),
                  ),
                  body: FlutterMap(
                    options: MapOptions(
                      initialCenter: currentLocation,
                      onTap: (tapPosition, point) {
                        setState(() {
                          currentLocation = point;
                        });
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: currentLocation,
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 65,
                  child: Scaffold(
                    body: state is GetAddressLoading ? const Center(
                      child: LinearProgressIndicator(),
                    ):GestureDetector(
                      onTap: () {
                        cubit.getAddress(currentLocation);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: double.infinity,
                          height: 65,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              "Confirm Location",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
