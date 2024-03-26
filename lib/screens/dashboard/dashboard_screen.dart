import 'package:ecom/controller/dashboard_controller.dart';
import 'package:ecom/controller/user_controller.dart';
import 'package:ecom/controller/wishlist_controller.dart';
import 'package:ecom/screens/account/account_details_screen.dart';
import 'package:ecom/screens/homescreen/home-screen.dart';
import 'package:ecom/screens/wishlist_screen/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/text_style.dart';
import '../cart_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  DashboardController controller = Get.put(DashboardController());


  @override
  void initState() {

    // Get.find<UserController>().getUserDetails();
    Get.find<WishlistController>().getWishlist();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        return Scaffold(
          body: IndexedStack(
            index: controller.controllerIndex.value,
            children: const [
              HomeScreen(),
              CartScreen(flag: true),
              WishListScreen(),
              AccountDetailsScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            selectedItemColor: const Color(0xff67C4A7),
            unselectedLabelStyle: TextStyles.k12Regular(),
            selectedLabelStyle: TextStyles.k12Bold(),
            currentIndex: controller.controllerIndex.value,
            onTap: (value){
              controller.controllerIndex.value = value;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "Home",
                activeIcon: Icon(Icons.home_filled)
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                  label: "Cart",
                  activeIcon: Icon(Icons.shopping_cart_rounded)
              ),BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                  label: "Favourite",
                  activeIcon: Icon(Icons.favorite)
              ),BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                  label: "Profile",
                  activeIcon: Icon(Icons.account_circle)
              ),
            ],
          ),
        );
      }
    );
  }
}
