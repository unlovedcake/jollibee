import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jollibee/app/global_variable/global_variable.dart';
import 'package:jollibee/app/logger/logger.dart';

import '../controllers/stores_controller.dart';

class StoresView extends StatefulWidget {
  const StoresView({super.key});

  @override
  State<StoresView> createState() => _StoresViewState();
}

class _StoresViewState extends State<StoresView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StoresController());

    return Scaffold(
        appBar: AppBar(
          title: const Text('StoresView'),
          centerTitle: true,
        ),
        body: Obx(
          () => Stack(
            children: [
              controller.isCurrentLocationStatus //|| controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Stack(
                      children: [
                        GoogleMap(
                          mapToolbarEnabled: false,
                          compassEnabled: false,
                          zoomControlsEnabled: false,
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.55),
                          zoomGesturesEnabled: true,
                          initialCameraPosition: CameraPosition(
                            target: controller.startLocation,
                            zoom: 14.0,
                          ),
                          markers: Set<Marker>.of(markers.value),
                          //polylines: Set<Polyline>.of(polylines),
                          // circles: {
                          //   Circle(
                          //       circleId: CircleId('1'),
                          //       center: controller.startLocation,
                          //       radius: 4000,
                          //       strokeWidth: 2,
                          //       fillColor: Colors.black12.withOpacity(0.2))
                          // },

                          mapType: MapType.terrain,
                          onMapCreated: (controllers) {
                            //controller.mapController.complete(controllers);

                            mapController = controllers;
                          },
                        ),
                        Positioned(
                          top: 10.0,
                          left: 10.0,
                          right: 10.0,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: controller.searchTextField,
                                    onChanged: (val) {
                                      if (val != '') {
                                        controller.searchInput.value = val;
                                      } else {
                                        controller.searchInfo.value = [];
                                      }
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Search',
                                      prefixIcon: const Icon(Icons.location_on),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          controller.searchInput.value =
                                              controller.searchTextField.text =
                                                  '';
                                        },
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.black,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  if (controller.searchInfo.value.isNotEmpty)
                                    ...controller.searchInfo.map((e) =>
                                        Container(
                                          color: Colors.white,
                                          child: ListTile(
                                            onTap: () async {
                                              FocusScope.of(context).unfocus();
                                              MyLogger.printInfo(
                                                  'Geo: ${e.geometry!.coordinates![0]} ${e.geometry!.coordinates![1]}');
                                              await controller.searchLocation(
                                                  e.geometry!.coordinates![1],
                                                  e.geometry!.coordinates![0]);
                                              controller.searchInfo.value = [];
                                            },
                                            leading: const Icon(Icons.place),
                                            title: Text(e.properties!.name!),
                                            // subtitle:
                                            //     Text(e.properties!.street!),
                                          ),
                                        ))
                                ],
                              )),
                        ),
                        if (controller.isLoading)
                          const Center(child: CircularProgressIndicator())
                      ],
                    ),
            ],
          ),
        ));
  }
}

// class StoresView extends GetView<StoresController> {
//   const StoresView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(StoresController());
//     controller.currentLocation();
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('StoresView'),
//           centerTitle: true,
//         ),
//         body: Obx(
//           () => Stack(
//             children: [
//               markers.isEmpty
//                   ? Center(child: CircularProgressIndicator())
//                   : Stack(
//                       children: [
//                         GoogleMap(
//                           mapToolbarEnabled: false,
//                           compassEnabled: false,
//                           zoomControlsEnabled: false,
//                           padding: EdgeInsets.only(
//                               bottom:
//                                   MediaQuery.of(context).size.height * 0.55),
//                           zoomGesturesEnabled: true,
//                           initialCameraPosition: CameraPosition(
//                             target: controller.startLocation,
//                             zoom: 14.0,
//                           ),
//                           markers: Set<Marker>.of(markers.value),
//                           //polylines: Set<Polyline>.of(polylines),
//                           // circles: {
//                           //   Circle(
//                           //       circleId: CircleId('1'),
//                           //       center: controller.startLocation,
//                           //       radius: 4000,
//                           //       strokeWidth: 2,
//                           //       fillColor: Colors.black12.withOpacity(0.2))
//                           // },

//                           mapType: MapType.normal,
//                           onMapCreated: (controllers) {
//                             //mapController = controller;
//                             controller.mapController.complete(controllers);
//                           },
//                           // onCameraMove: (CameraPosition cameraPositions) {
//                           //   cameraPosition = cameraPositions;
//                           // },
//                         ),
//                         Positioned(
//                           top: 30.0,
//                           left: 10.0,
//                           right: 10.0,
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 20.0),
//                             child: Obx(() => Column(
//                                   children: [
//                                     TextField(
//                                       onChanged: (val) {
//                                         print('Search Value $val');
//                                         if (val != '') {
//                                           controller.placeAutoComplete(val);
//                                         } else {
//                                           val = '';
//                                           controller.searchInfo.clear();
//                                         }
//                                       },
//                                       decoration: InputDecoration(
//                                         fillColor: Colors.blue,
//                                         hintText: 'Search',
//                                         prefixIcon: Icon(Icons.location_on),
//                                         border: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10.0),
//                                         ),
//                                       ),
//                                     ),
//                                     ...controller.searchInfo
//                                         .map((e) => Container(
//                                               color: Colors.white,
//                                               child: ListTile(
//                                                 leading: Icon(Icons.place),
//                                                 title:
//                                                     Text(e.properties!.name!),
//                                               ),
//                                             ))
//                                   ],
//                                 )),
//                           ),
//                         ),
//                       ],
//                     ),
//             ],
//           ),
//         ));
//   }
// }
