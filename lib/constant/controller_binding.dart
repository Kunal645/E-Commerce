import 'package:ecom/controller/cart_controller.dart';
import 'package:ecom/controller/category_controller.dart';
import 'package:ecom/controller/checkout_controller.dart';
import 'package:ecom/controller/dashboard_controller.dart';
import 'package:ecom/controller/homescreen_controller.dart';
import 'package:ecom/controller/user_controller.dart';
import 'package:ecom/controller/wishlist_controller.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings{
  @override
  void dependencies() {
        Get.lazyPut(() => UserController());
        Get.lazyPut(() => HomeScreenController());
        Get.lazyPut(() => DashboardController());
        Get.lazyPut(() => CartController(),fenix: false);
        Get.lazyPut(() => WishlistController(),fenix: false);
        Get.lazyPut(() => CheckoutController(),fenix: false);
        Get.lazyPut(() => CategoryController(),fenix: false);
  }
}