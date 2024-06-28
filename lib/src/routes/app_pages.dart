import 'package:get/get.dart';
import 'package:gvg_order/src/bindings/basket/basket_bindings.dart';
import 'package:gvg_order/src/bindings/cupon/cupon_bindings.dart';
import 'package:gvg_order/src/bindings/login/login_bindings.dart';
import 'package:gvg_order/src/bindings/outlets/outlets_bindings.dart';
import 'package:gvg_order/src/bindings/payment/payment_bindings.dart';
import 'package:gvg_order/src/bindings/product/product_bindings.dart';
import 'package:gvg_order/src/ui/basket/basket_page.dart';
import 'package:gvg_order/src/ui/coupon/coupon_page.dart';
import 'package:gvg_order/src/ui/outlets/outlets_page.dart';
import '../bindings/app/app_bindings.dart';
import '../bindings/home/home_bindings.dart';
import '../bindings/orders/orders_bindings.dart';
import '../ui/app.dart';
import '../ui/home/home_page.dart';
import '../ui/login/login_page.dart';
import '../ui/orders/orders_page.dart';
import '../ui/payment/payment_page.dart';
import '../ui/product/product_page.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL,
      page: () => const AppPage(),
      binding: AppBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.PRODUCT,
      page: () => const ProductPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: Routes.BASKET,
      page: () => const BasketPage(),
      binding: BasketBindings(),
    ),
    GetPage(
      name: Routes.PAYMENT,
      page: () => const PaymentPage(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: Routes.COUPON,
      page: () => const CouponPage(),
      binding: CouponBindings(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginPage(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: Routes.OUTLETS,
      page: () => const OutletsPage(),
      binding: OutletsBindings(),
    ),
    GetPage(
      name: Routes.ORDERS,
      page: () => const OrdersPage(),
      binding: OrdersBindings(),
    ),
  ];
}
