import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/controller/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/strings_constant.dart';
import '../constant/widgets/flutter_toast.dart';
import '../../controller/cart_controller.dart';
import '../../controller/category_controller.dart';
import '../../controller/checkout_controller.dart';
import '../../controller/homescreen_controller.dart';
import '../../controller/wishlist_controller.dart';
import 'package:ecom/controller/dashboard_controller.dart';
import '../model/user_model.dart';
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

      UserModel userModel = UserModel(email: user!.email.toString(),name: Name(firstname: nameController.value.text),id: user.uid);

      await FirebaseFirestore.instance.collection(StringConstant.pathUserCollection).doc(user.uid).set(userModel.toJson());

      navigates();

    } on FirebaseAuthException catch (e) {
      flutterToast(e.code);
    } catch (e) {
      flutterToast(e.toString());
    }

    isLoading.value = false;
  }

  singIn() async {
    isLoading.value = true;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: mailController.value.text.trim(),
          password: passController.value.text.trim());

      navigates();

    } on FirebaseAuthException catch (e) {
      flutterToast(e.code);
    } catch (e) {
       print(e);
    }
    isLoading.value = false;
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      User? user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      UserModel userModel = UserModel(
          email: user!.email.toString(),
          name: Name(firstname: user.displayName!.split(" ").first.toString(),lastname: user.displayName!.split(" ").last.toString()),
          id: user.uid,
          profilePic: user.photoURL
      );
      await FirebaseFirestore.instance.collection(StringConstant.pathUserCollection).doc(user.uid).set(userModel.toJson());
      navigates();
    } on Exception catch (e) {
      print('exception->$e');
    }
  }

  forgotPassword() async {
    isLoading.value = true;
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: mailController.value.text)
          .then((th){
        flutterToast("Send mail for reset password link,Check your mail");
      }).catchError((error){
        print(error);
        flutterToast(error.message);
      }).onError((error, stackTrace){
        flutterToast(error.toString());
      });
      Get.back();
    }
    catch(e){
      print(e);
    }
    isLoading.value = false;
  }

  navigates() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool(StringConstant.isLoggedIn, true);
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => HomeScreenController());
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => CartController(),fenix: false);
    Get.lazyPut(() => WishlistController(),fenix: false);
    Get.lazyPut(() => CheckoutController(),fenix: false);
    Get.lazyPut(() => CategoryController(),fenix: false);
    Get.offAll(() => const DashboardScreen());
  }

}