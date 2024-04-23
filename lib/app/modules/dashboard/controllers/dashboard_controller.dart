import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../home/views/home_view.dart';
import '../../order/views/order_view.dart';
import '../../promos/views/promos_view.dart';
import '../../stores/views/stores_view.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Widget> screens = [
    HomeView(),
    PromosView(),
    OrderView(),
    StoresView(),
  ];

  final List<BottomNavigationBarItem> bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.local_offer),
      label: 'Promos',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: 'Order',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.store),
      label: 'Stores',
    ),
  ];

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

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
}
