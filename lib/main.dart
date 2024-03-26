import 'package:ecom/model/cart_model_hive.dart';
import 'package:ecom/model/product_model_hive.dart';
import 'package:ecom/model/wishlist_model_hive.dart';
import 'package:ecom/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'constant/controller_binding.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(CartModelAdapter());
  Hive.registerAdapter(CartProductsAdapter());
  Hive.registerAdapter(WishlistModelAdapter());
  await Hive.openBox('productBox');
  await Hive.openBox('cartBox');
  await Hive.openBox('wishlistBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_ , child) {
        return GetMaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          initialBinding: ControllerBinding(),
          home: const SplashScreen(),
        );
      }
    );
  }
}
