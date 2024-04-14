import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class Address {
  String? locality;
  String? street;
  String? postalCode;
  String? country;

  Address({this.locality, this.street, this.postalCode, this.country});
}

class LocationService with ChangeNotifier {
  MapController _mapController = MapController();
  Address _address =
      Address(country: "", locality: "", postalCode: "", street: "");

  Address get address {
    return _address;
  }

  MapController get mapController {
    return _mapController;
  }

  LocationService() {
    _getUserPermission();
  }
  double _lat = 0.0;
  double _long = 0.0;

  double get long {
    return _long;
  }

  double get lat {
    return _lat;
  }

  setLatLong(lat, long) async {
    _lat = lat;
    _long = long;
    _address = await getAddressFromLatLng(LatLng(_lat, _long));
    notifyListeners();
  }

  Future<Address> getAddressFromLatLng(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      Placemark place = placemarks[0];
      return Address(
          street: place.street,
          postalCode: place.postalCode,
          country: place.country,
          locality: place.locality);
      // String address =
      //     "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
      // return address;
    } catch (e) {
      throw Error();
    }
  }

  getCurrentUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _lat = position.latitude;
    _long = position.longitude;
    _address = await getAddressFromLatLng(LatLng(_lat, _long));
    _mapController.move(LatLng(_lat, _long), 13);
    log("$_lat, $_long");
    notifyListeners();
  }

  _getUserPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    switch (permission) {
      case LocationPermission.denied:
        // TODO: Handle this case.
        break;
      case LocationPermission.deniedForever:
        // TODO: Handle this case.
        break;
      case LocationPermission.whileInUse:
        // TODO: Handle this case.
        getCurrentUserLocation();
        break;
      case LocationPermission.always:
        // TODO: Handle this case.
        getCurrentUserLocation();
        break;
      case LocationPermission.unableToDetermine:
        // TODO: Handle this case.
        break;
    }
  }
}
