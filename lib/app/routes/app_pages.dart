import 'package:get/get.dart';

import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/order/bindings/order_binding.dart';
import '../modules/order/views/order_view.dart';
import '../modules/promo_details/bindings/promo_details_binding.dart';
import '../modules/promo_details/views/promo_details_view.dart';
import '../modules/promos/bindings/promos_binding.dart';
import '../modules/promos/views/promos_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/stores/bindings/stores_binding.dart';
import '../modules/stores/views/stores_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const DASHBOARD = Routes.DASHBOARD;
  static const HOME = Routes.HOME;
  static const PROMOS = Routes.PROMOS;
  static const ORDER = Routes.ORDER;
  static const STORES = Routes.STORES;
  static const SPLASH = Routes.SPLASH;
  static const PROMO_DETAILS = Routes.PROMO_DETAILS;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.PROMOS,
      page: () => const PromosView(),
      binding: PromosBinding(),
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => const OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.STORES,
      page: () => const StoresView(),
      binding: StoresBinding(),
    ),
    GetPage(
      name: _Paths.PROMO_DETAILS,
      page: () => PromoDetailsView(),
      binding: PromoDetailsBinding(),
    ),
  ];
}
