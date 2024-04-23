import 'package:get/get.dart';

import '../controllers/stores_controller.dart';

class StoresBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StoresController());
  }
}
