import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jollibee/app/logger/logger.dart';

import '../../../global_variable/global_variable.dart';
import '../../../repositories/stores_repository.dart';
import '../../utils/custom_snackbar.dart';

class StoresController extends GetxController {
  Position? _currentUserPosition;
  LatLng startLocation = const LatLng(10.2640, 123.8425);
  LatLng endLocation = const LatLng(10.3157, 123.8854);

  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  @override
  void onInit() {
    super.onInit();
    currentLocation();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'Error',
          message: 'Location services are disabled. Please enable the services',
          duration: const Duration(seconds: 4));

      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        CustomSnackBar.showCustomErrorSnackBar(
            title: 'Error',
            message: 'Location permissions are denied',
            duration: const Duration(seconds: 4));

        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'Error',
          message:
              'Location permissions are permanently denied, we cannot request permissions.',
          duration: const Duration(seconds: 4));

      return false;
    }
    return true;
  }

  Future<void> currentLocation() async {
    try {
      final hasPermission = await _handleLocationPermission();
      if (!hasPermission) return;
      _currentUserPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      startLocation = LatLng(
        _currentUserPosition!.latitude,
        _currentUserPosition!.longitude,
      );

      markers.value = await SearchRepository.getNearbyPlaces(
          'Jollibee',
          _currentUserPosition!.latitude.toString(),
          _currentUserPosition!.longitude.toString());

      await SearchRepository.addPolyLine(
          _currentUserPosition!.latitude.toString(),
          _currentUserPosition!.longitude.toString());

      MyLogger.printInfo('Start Location: $startLocation Markers: $markers ');
    } catch (e) {
      MyLogger.printInfo('Error : $e ');
    }
  }
}
