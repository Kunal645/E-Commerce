import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/controller/user_controller.dart';
import 'package:ecom/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../constant/widgets/flutter_toast.dart';
import '../../controller/cart_controller.dart';
import '../../controller/category_controller.dart';
import '../../controller/checkout_controller.dart';
import '../../controller/homescreen_controller.dart';
import '../../controller/wishlist_controller.dart';
import 'package:ecom/controller/dashboard_controller.dart';
import '../screens/dashboard/dashboard_screen.dart';

class LoginController extends GetxController{

  Rx<TextEditingController> mailController = TextEditingController().obs;
  Rx<TextEditingController> passController = TextEditingController().obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> conPassController = TextEditingController().obs;
  RxBool showPassword = false.obs;
  RxBool showConPassword = false.obs;
  RxBool isLoading = false.obs;

  register() async {
    isLoading.value = true;
    try {
      User? user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: mailController.value.text.trim(),
          password: passController.value.text.trim())).user;
      print(user);
      UserModel userModel = UserModel(email: user!.email.toString(),name: Name(firstname: nameController.value.text),id: user.uid);
      FirebaseFirestore.instance
          .collection("user")
          .doc(user.uid)
          .set(userModel.toJson());
      var response = await FirebaseFirestore.instance
          .collection("user")
          .doc(user.uid)
          .get();
      print(response);
      UserModel.fromJson(response.data()!);
      Get.lazyPut(() => UserController());
      Get.lazyPut(() => HomeScreenController());
      Get.lazyPut(() => DashboardController());
      Get.lazyPut(() => CartController(),fenix: false);
      Get.lazyPut(() => WishlistController(),fenix: false);
      Get.lazyPut(() => CheckoutController(),fenix: false);
      Get.lazyPut(() => CategoryController(),fenix: false);
      // await Get.find<UserController>().getUser(UserModel.fromJson(response.data()!));
      Get.offAll(() => const DashboardScreen());
    } on FirebaseAuthException catch (e) {
      flutterToast(e.code);
    } catch (e) {
      print(e);
      flutterToast(e.toString());
    }
    isLoading.value = false;
  }

  singIn() async {
    isLoading.value = true;
    try {
      User? user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: mailController.value.text.trim(),
          password: passController.value.text.trim())).user;
    print(user);
    // var response = await FirebaseFirestore.instance
    //     .collection("user")
    //     .doc(user!.uid)
    //     .get();
    // print(response);
      Get.lazyPut(() => UserController());
      Get.lazyPut(() => HomeScreenController());
      Get.lazyPut(() => DashboardController());
      Get.lazyPut(() => CartController(),fenix: false);
      Get.lazyPut(() => WishlistController(),fenix: false);
      Get.lazyPut(() => CheckoutController(),fenix: false);
      Get.lazyPut(() => CategoryController(),fenix: false);
      // await Get.find<UserController>().getUser(UserModel.fromJson(response.data()!));
      Get.offAll(() => const DashboardScreen());
    } on FirebaseAuthException catch (e) {
    flutterToast(e.code);
    // ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(e.code)));
    if (e.code == "weak-password") {
    print('The password provided is too weak.');
    } else if (e.code == "email-already-in-use") {
    print('An account already exists for that email.');
    }
    } catch (e) {
    print(e);
    }
    isLoading.value = false;
  }

  forgotPassword() async {
    isLoading.value = true;
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: mailController.value.text)
          .then((th){
        flutterToast("Send mail for reset password link,Check your mail");
      })
          .catchError((error){
        print(error);
        flutterToast(error.message);
      })
          .onError((error, stackTrace){
        flutterToast(error.toString());
      });

      Get.back();
    }
    catch(e){
     print(e);
    }
    isLoading.value = false;
  }

}