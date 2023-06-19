import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_tracker/providers/location_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String screenName = "home-screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LocationProvider locationProvider = LocationProvider();
  CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(29.9668, 32.5498), zoom: 15);
  Set<Marker> marker = {};
  double long = 0;
  double lati = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: cameraPosition,
              myLocationButtonEnabled: true,
              compassEnabled: true,
              myLocationEnabled: true,
              onMapCreated: (GoogleMapController controller) {},
              markers: marker,
              onTap: (l) => {setMarker(l.longitude, l.latitude)},
            ),
          ),
        ],
      ),
    );
  }

  void setMarker(double longitude, double latitude) {
    Marker userMarker = Marker(
        markerId: const MarkerId('userMarker'),
        position: LatLng(latitude, longitude));
    setState(() {
      marker.add(userMarker);
    });
  }

  void getLocation() async {
    locationProvider.trackUserLocation().listen((event) {});
  }
}
