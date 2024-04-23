import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/promos_controller.dart';

class PromosView extends GetView<PromosController> {
  const PromosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PromosView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PromosView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
