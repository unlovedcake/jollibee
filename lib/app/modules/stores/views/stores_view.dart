import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jollibee/app/global_variable/global_variable.dart';

import '../controllers/stores_controller.dart';

class StoresView extends GetView<StoresController> {
  const StoresView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StoresController());
    controller.currentLocation();
    return Scaffold(
        appBar: AppBar(
          title: const Text('StoresView'),
          centerTitle: true,
        ),
        body: Obx(
          () => Stack(
            children: [
              markers.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : GoogleMap(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.55),
                      zoomGesturesEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: controller.startLocation,
                        zoom: 14.0,
                      ),
                      markers: Set<Marker>.of(markers.value),
                      polylines: Set<Polyline>.of(polylines),
                      // circles: {
                      //   Circle(
                      //       circleId: CircleId('1'),
                      //       center: controller.startLocation,
                      //       radius: 4000,
                      //       strokeWidth: 2,
                      //       fillColor: Colors.black12.withOpacity(0.2))
                      // },

                      mapType: MapType.normal,
                      onMapCreated: (controllers) {
                        //mapController = controller;
                        controller.mapController.complete(controllers);
                      },
                      // onCameraMove: (CameraPosition cameraPositions) {
                      //   cameraPosition = cameraPositions;
                      // },
                    ),
            ],
          ),
        ));
  }
}
