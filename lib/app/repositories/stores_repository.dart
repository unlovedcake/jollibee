import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:jollibee/app/models/nearby_model.dart';
import 'package:jollibee/app/routes/app_pages.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../global_variable/global_variable.dart';

class SearchRepository {
  static Future<void> getNearbyPlaces(String fastFoodName, String latitude,
      String longitude, BuildContext context) async {
    String googleApiKey = dotenv.env['APP_API_KEY_MAP'] ?? '';

    print('dotenv ${googleApiKey}');

    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=4000&types=restaurant&name=$fastFoodName&key=$googleApiKey');

    var response = await http.post(url);

    nearbyPlacesResponse =
        NearbyPlacesResponse.fromJson(jsonDecode(response.body));
  }
}
