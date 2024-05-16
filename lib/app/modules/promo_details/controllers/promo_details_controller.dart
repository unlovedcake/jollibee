import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jollibee/app/firebase_instances/firebase_instance.dart';
import 'package:jollibee/app/models/product_promos_model.dart';
import 'package:jollibee/app/repositories/promo_repository.dart';

import '../../../global_variable/global_variable.dart';
import '../../../logger/logger.dart';

class PromoDetailsController extends GetxController {
  //TODO: Implement PromoDetailsController

  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _fetchPromos();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _fetchPromos();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();

    scrollController.dispose();
  }

  Future<void> _fetchPromos() async {
    try {
      if (isMoreData.value) {
        final promoDataResponse = await PromoRepository.fetchVisitors();

        if (promoDataResponse.length < 10) {
          isMoreData.value = false;
          MyLogger.printInfo('No More Data');
        }

        MyLogger.printInfo('Fetch Promo: ${promoDataResponse.length}');

        promoDataResponse
            .sort((a, b) => a.product_name.compareTo(b.product_name));
        promos.addAll(promoDataResponse);
      }
    } on Exception catch (e) {
      print('Error $e');
    } catch (e) {
      print('Error $e');
    }
  }
}
