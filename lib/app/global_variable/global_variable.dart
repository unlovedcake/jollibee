import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jollibee/app/models/product_promos_model.dart';

import '../models/nearby_model.dart';

final isMoreData = true.obs;
final promos = <Promo>[].obs;
final markers = <Marker>[].obs;
GoogleMapController? mapController;

List<Polyline> polylines = [];
NearbyPlacesResponse nearbyPlacesResponse = NearbyPlacesResponse();
