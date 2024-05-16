import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jollibee/app/logger/logger.dart';
import 'package:jollibee/app/models/auto_search_place_model.dart';
import 'package:jollibee/app/utils/abstract_base_controller.dart';
import 'dart:ui' as ui;
import '../../../global_variable/global_variable.dart';
import '../../../repositories/stores_repository.dart';
import '../../../utils/custom_snackbar.dart';

enum SearchLocationStatus { initial, loading, succeeded, failed }

enum CurrentLocationStatus { initial, loading, succeeded, failed }

class StoresController extends AbstractBaseController {
  final status = SearchLocationStatus.initial.obs;
  final currentLocationStatus = CurrentLocationStatus.initial.obs;
  Position? _currentUserPosition;
  late LatLng startLocation;

  LatLng endLocation = const LatLng(10.3157, 123.8854);

  late Worker _searchDebounceWorker;

  bool get isLoading => status.value == SearchLocationStatus.loading;

  bool get isCurrentLocationStatus =>
      currentLocationStatus.value == CurrentLocationStatus.loading;

  // final Completer<GoogleMapController> mapController =
  //     Completer<GoogleMapController>();
  //GoogleMapController? mapController;

  final searchTextField = TextEditingController();

  final searchInfo = <Feature>[].obs;
  final searchInput = ''.obs;

  final ctx = Get.context as BuildContext;

  @override
  void onInit() {
    super.onInit();
    currentLocation();
    placeAutoComplete();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    _searchDebounceWorker.dispose();
  }

  void placeAutoComplete() {
    const duration = Duration(milliseconds: 1000);
    _searchDebounceWorker = debounce(
      searchInput,
      (_) => addressSuggestion(searchInput.value)
          .then((val) => searchInfo.value = val),
      time: duration,
    );
  }

  Future<List<Feature>> addressSuggestion(String address) async {
    if (searchInput.trim().isEmpty || searchInput.value.length < 3) {
      MyLogger.printInfo('Search query minimum requirements not met');
      return [];
    }
    final response = await Dio().get('https://photon.komoot.io/api',
        queryParameters: {"q": address, "limit": 10});

    final json = response.data;

    MyLogger.printInfo('Address: $json');

    return (json['features'] as List).map((e) => Feature.fromJson(e)).toList();
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

      currentLocationStatus.value = CurrentLocationStatus.loading;

      final response = await SearchRepository.getNearbyPlaces(
        'Jollibee',
        _currentUserPosition!.latitude.toString(),
        _currentUserPosition!.longitude.toString(),
      );

      currentLocationStatus.value = CurrentLocationStatus.succeeded;
      await getMarkers(_currentUserPosition!.latitude.toString(),
          _currentUserPosition!.longitude.toString());
      //markers.value = response;

      MyLogger.printInfo('Start Location: $startLocation Markers: $markers ');
    } catch (e) {
      MyLogger.printInfo('Error : $e ');

      currentLocationStatus.value = CurrentLocationStatus.failed;
    }
  }

  Future getMarkers(String latitude, String longitude) async {
    List<double> distanceKilometers = [];
    String lat = '';
    String lang = '';
    String imgurlMyLocation = "https://www.fluttercampus.com/img/car.png";

    Uint8List bytesMyLocation =
        (await NetworkAssetBundle(Uri.parse(imgurlMyLocation))
                .load(imgurlMyLocation))
            .buffer
            .asUint8List();
    Uint8List imageMakerLogo = await loadNetworkImage(
        'https://cdn.iconscout.com/icon/free/png-256/free-fast-food-location-4596379-3813390.png?f=webp');
    final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
        imageMakerLogo.buffer.asUint8List(),
        targetHeight: 100,
        targetWidth: 100);
    final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
    final ByteData? byteData =
        await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List resizedImageMarker = byteData!.buffer.asUint8List();

    for (int i = 0; i < nearbyPlacesResponse.results!.length; i++) {
      lat = nearbyPlacesResponse.results![i].geometry!.location!.lat.toString();
      lang =
          nearbyPlacesResponse.results![i].geometry!.location!.lng.toString();
      String markerID = nearbyPlacesResponse.results![i].reference.toString();
      String name = nearbyPlacesResponse.results![i].name.toString();
      String vicinity = nearbyPlacesResponse.results![i].vicinity.toString();

      var distanceInMeters = Geolocator.distanceBetween(double.parse(latitude),
          double.parse(longitude), double.parse(lat), double.parse(lang));

      double distanceKm = distanceInMeters / 1000;

      distanceKilometers.add(distanceKm);

      final distanceKms =
          nearbyPlacesResponse.results?[i].distanceKilometer = distanceKm;

      //Jollibee Location
      markers.add(
        Marker(
          markerId: MarkerId(markerID),
          position: LatLng(double.parse(lat), double.parse(lang)),
          infoWindow: InfoWindow(
            title: name,
            snippet: '${distanceKm.toStringAsFixed(1)} km ',
          ),
          consumeTapEvents: true,
          onTap: () {
            mapController?.showMarkerInfoWindow(MarkerId(markerID));
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              context: ctx,
              builder: (BuildContext context) {
                return Container(
                  alignment: Alignment.center,
                  height: 400,
                  color: Colors.blue,
                  child: InkWell(
                    splashColor: Colors.blue,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          color: Colors.white60,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(right: 4, left: 4),
                        onTap: () {},
                        title: Text(
                          vicinity,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${distanceKm.toStringAsFixed(1)} km',
                          style: const TextStyle(fontSize: 14),
                        ),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward_ios_outlined)),
                      ),
                    ),
                  ),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Center(
                  //       child: Text(
                  //         vicinity,
                  //         style: TextStyle(fontSize: 20),
                  //       ),
                  //     ),
                  //     Center(
                  //       child: Text(
                  //         '${distanceKm.toStringAsFixed(1)} km',
                  //         style: TextStyle(fontSize: 20),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                );
              },
            );
          },
          icon: BitmapDescriptor.fromBytes(resizedImageMarker),
        ),
      );
    }

    //User Location
    markers.add(Marker(
      markerId: const MarkerId('user'),
      position: LatLng(double.parse(latitude), double.parse(longitude)),
      //_currentUserPosition.latitude, _currentUserPosition.longitude,
      infoWindow: const InfoWindow(
        title: 'Love',
        snippet: 'Current Location',
      ),

      consumeTapEvents: true,
      onTap: () {
        mapController?.showMarkerInfoWindow(const MarkerId('user'));
      },
      icon: BitmapDescriptor.fromBytes(bytesMyLocation),
    ));
  }

  Future<Uint8List> loadNetworkImage(path) async {
    final completed = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completed.complete(info)));
    final imageInfo = await completed.future;
    final byteData =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<void> searchLocation(double lat, double long) async {
    status.value = SearchLocationStatus.loading;
    try {
      await mapController
          ?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        target: LatLng(lat, long),
        zoom: 14.0,
      )));
      startLocation = LatLng(lat, long);

      final response = await SearchRepository.getNearbyPlaces(
          'Jollibee', lat.toString(), long.toString());

      status.value = SearchLocationStatus.succeeded;
      markers.clear();

      await getMarkers(lat.toString(), long.toString());

      MyLogger.printInfo('Start Locationz: $startLocation Markers: $markers ');
      refresh();
    } catch (e) {
      status.value = SearchLocationStatus.failed;
      MyLogger.printInfo('Error : $e ');
    }
  }
}
