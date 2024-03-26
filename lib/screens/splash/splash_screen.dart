import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:ecom/screens/dashboard/dashboard_screen.dart';
import 'package:ecom/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/strings_constant.dart';
import '../Intro/intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterSplashScreen.gif(
        gifPath: 'assets/images/splash.gif',
        gifWidth: 269,
        gifHeight: 474,
        asyncNavigationCallback: () async {
          SharedPreferences sharedPref = await SharedPreferences.getInstance();
          if(sharedPref.getBool(StringConstant.isLoggedIn) != null && sharedPref.getBool(StringConstant.isLoggedIn)!){
            Get.offAll(() => DashboardScreen());
          }
          else{
            Get.offAll(() => OnBoarding());
          }

        },
        onInit: () async {
          debugPrint("onInit");
        },
        onEnd: () async {
          debugPrint("onEnd 1");
        },
      ),
    );
  }
}
