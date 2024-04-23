import 'package:get/get.dart';

import '../controllers/promo_details_controller.dart';

class PromoDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PromoDetailsController>(
      () => PromoDetailsController(),
    );
  }
}
