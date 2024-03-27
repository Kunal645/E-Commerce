import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/constant/strings_constant.dart';
import 'package:ecom/model/user_model.dart';
import 'package:ecom/repository/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserController extends GetxController{

  UserRepo repo = UserRepo();

  Rx<File> imageFile = File("").obs;
  Rx<UserModel> user = UserModel().obs;

  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> mobileNumberController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> addressLineController = TextEditingController().obs;
  Rx<TextEditingController> streetController = TextEditingController().obs;
  Rx<TextEditingController> landMarkController = TextEditingController().obs;
  Rx<TextEditingController> cityController = TextEditingController().obs;
  Rx<TextEditingController> zipCodeController = TextEditingController().obs;

  RxString addressString = "".obs;

  FirebaseFirestore firebase = FirebaseFirestore.instance;
  FirebaseStorage fbStorage = FirebaseStorage.instance;

  Stream<DocumentSnapshot> getStream() {
    var response = firebase.collection(StringConstant.pathUserCollection).doc(FirebaseAuth.instance.currentUser!.uid).snapshots();
    return response;
  }

  getUserDetails(UserModel userModel) async {
    user.value = userModel;
    user.value.id = FirebaseAuth.instance.currentUser!.uid;
    addressString.value =
    "${user.value.address?.addressLine != null && user.value.address!.addressLine!.isNotEmpty ? '${user.value.address?.addressLine!.replaceAll(",", "")}, ' : ""}"
    "${user.value.address?.street != null && user.value.address!.street!.isNotEmpty ? "${user.value.address!.street!.replaceAll(",", "")}, " : ""}"
    "${user.value.address?.landMark != null && user.value.address!.landMark!.isNotEmpty ? "${user.value.address!.landMark!.replaceAll(",", "")}, " : ""}"
    "${user.value.address?.city != null && user.value.address!.city!.isNotEmpty ? "${user.value.address!.city!.replaceAll(",", "")} - " : ""}"
    "${user.value.address?.zipcode != null && user.value.address!.zipcode!.isNotEmpty ? user.value.address!.zipcode!.replaceAll(",", "") : ""}";

    firstNameController.value.text = user.value.name!.firstname ?? "";
    lastNameController.value.text = user.value.name!.lastname ?? "";
    mobileNumberController.value.text = user.value.phone ?? "";
    emailController.value.text = user.value.email ?? "";
    addressLineController.value.text = user.value.address?.addressLine ?? "";
    streetController.value.text = user.value.address?.street ?? "";
    landMarkController.value.text = user.value.address?.landMark ?? "";
    cityController.value.text = user.value.address?.city ?? "";
    zipCodeController.value.text = user.value.address?.zipcode ?? "";
  }

  updateUserData(){
    UserModel updateUser = UserModel(
      id: user.value.id,
      email: emailController.value.text,
      name: Name(firstname: firstNameController.value.text,lastname: lastNameController.value.text),
      phone: mobileNumberController.value.text,
      address: Address(
        city: cityController.value.text.trim(),
        addressLine: addressLineController.value.text.trim(),
        street: streetController.value.text,
        landMark: landMarkController.value.text,
        zipcode:  zipCodeController.value.text.trim(),
      )
    );
    firebase.collection(StringConstant.pathUserCollection).doc(user.value.id.toString()).update(updateUser.toJson());
  }

  updateProfilePic(File value) async {
    try {
      await fbStorage.ref(StringConstant.profilePic).child(user.value.id.toString()).putFile(value);
      String url = await fbStorage.ref(StringConstant.profilePic).child(user.value.id.toString()).getDownloadURL();
      firebase.collection(StringConstant.pathUserCollection).doc(user.value.id.toString()).update({StringConstant.profilePic : url});
      user.value.profilePic = url;
      user.update((val) { });
    } catch (e) {
      print('error occurred');
    }
  }

}