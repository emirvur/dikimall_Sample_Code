import 'package:dikimall/services/APIServices.dart';
import 'package:dikimall/services/IAPIServices.dart';
import 'package:dikimall/utils/sabit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'locator.dart';

class MapActivity extends StatefulWidget {
  final bool issearch;
  MapActivity({this.issearch});
  @override
  _MapActivityState createState() => _MapActivityState();
}

class _MapActivityState extends State<MapActivity> {
  Position _center;
  Position _currentLocation;
  IAPIService _apiservice = locator<APIServices>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLocation();
  }

  Future<Position> locateUser() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    var x = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      // forceAndroidLocationManager: true,
    );
    return x;
  }

  getUserLocation() async {
    try {
      await EasyLoading.show(
        status: 'Konumunuz belirleniyor',
        maskType: EasyLoadingMaskType.black,
      );
      _currentLocation = await locateUser();
      setState(() {
        _center = Position(
            latitude: _currentLocation.latitude,
            longitude: _currentLocation.longitude);
      });

      List<Placemark> placemarks =
          await placemarkFromCoordinates(_center.latitude, _center.longitude);
      Placemark placeMark = placemarks[0];
      String name = placeMark.name;
      String subLocality = placeMark.subLocality;
      String locality = placeMark.locality;
      String administrativeArea = placeMark.administrativeArea;
      String postalCode = placeMark.postalCode;
      String country = placeMark.country;
      String address =
          " 11 ${name}, 222 ${subLocality}, 33${locality},4 ${administrativeArea} 5${postalCode},6 ${country}";
      print(address.toString());
      String addressupd = "${administrativeArea} - ${country}";
      if (widget.issearch ?? false) {
        EasyLoading.dismiss();
        Navigator.of(context).pop(addressupd);
        return;
      }
      await _apiservice.updateLocation(Sabit.user.id, addressupd);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Konumunuz başarıyla güncellendi')),
      );
      Sabit.user.location = administrativeArea + " - " + country;
      EasyLoading.dismiss();
      Navigator.of(context).pop(1);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata var' + e.toString())),
      );
      EasyLoading.dismiss();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text(""),
        ));
  }
}
