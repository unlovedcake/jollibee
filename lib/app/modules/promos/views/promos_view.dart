import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/promos_controller.dart';

class PromosView extends GetView<PromosController> {
  const PromosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PromosController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('PromosView'),
        centerTitle: true,
      ),
      body: Center(
          child: OutlinedButton(
              onPressed: () {
                controller.currentLocation();
              },
              child: Text('Click'))),
    );
  }
}
