import 'package:get/get.dart';
import 'package:jollibee/app/logger/logger.dart';
import 'package:jollibee/app/repositories/stores_repository.dart';
import 'package:jollibee/app/utils/abstract_base_controller.dart';

class PromosController extends AbstractBaseController {
  //TODO: Implement PromosController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  @override
  Future<void> currentLocation() async {
    MyLogger.printInfo("Splash Controller");
  }
}
