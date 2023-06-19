import 'package:location/location.dart';

class LocationProvider {
  Location locationManager = Location();
  Future<bool> isServiceEnabled() async {
    var serviceEnabled = await locationManager.serviceEnabled();
    return serviceEnabled;
  }

  Future<bool> requestService() async {
    var serviceEnabled = await locationManager.requestService();
    return serviceEnabled;
  }

  Future<bool> isPermissionGranted() async {
    var permissionStatus = await locationManager.hasPermission();
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> requestPermission() async {
    var permissionStatus = await locationManager.requestPermission();
    return permissionStatus == PermissionStatus.granted;
  }

  Future<LocationData?> getLocation() async {
    bool isPermissionGranted = await requestPermission();
    bool isServiceEnabled = await requestService();
    if (!isPermissionGranted || !isServiceEnabled) {
      return null;
    }

    return locationManager.getLocation();
  }

  Stream<LocationData> trackUserLocation() {
    return locationManager.onLocationChanged;
  }
}
