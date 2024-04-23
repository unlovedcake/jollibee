import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/stores_controller.dart';

class StoresView extends GetView<StoresController> {
  const StoresView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StoresView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StoresView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
