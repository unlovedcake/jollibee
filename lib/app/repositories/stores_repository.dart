import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:jollibee/app/models/nearby_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../global_variable/global_variable.dart';

class SearchRepository {
  static Future<void> getNearbyPlaces(
      String fastFoodName, String latitude, String longitude) async {
    String googleApiKey = dotenv.env['APP_API_KEY_MAP'] ?? '';
    String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=4000&types=restaurant&name=$fastFoodName&key=$googleApiKey';

    final urlParse = Uri.parse(url);

    final response = await http.post(urlParse);

    nearbyPlacesResponse =
        NearbyPlacesResponse.fromJson(jsonDecode(response.body));
  }
}
