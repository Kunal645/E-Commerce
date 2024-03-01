import 'dart:io';

import 'package:ecom/constant/strings_constant.dart';
import 'package:ecom/model/user_model.dart';
import 'package:ecom/repository/user_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  SharedPreferences? sharedPref;

  getUser() async {
    sharedPref = await SharedPreferences.getInstance();
    var tempString = sharedPref?.getString(StringConstant.firstName);
    if(tempString == null || tempString.toString().isEmpty){
      UserModel user = await repo.getUserData();
      setUserDetails(
          user.name!.firstname ?? "", user.name!.lastname ?? "",
          user.phone ?? "", user.email ?? "",
          user.address?.addressLine ?? "", user.address?.street ?? "",
          user.address?.landMark ?? "", user.address?.city ?? "", user.address?.zipcode ?? "",
          sharedPref?.getString(StringConstant.profilePic) ?? ""
      );
    }
    getUserDetails();
  }

  setUserDetails(firstName,lastName,phone,email,addressLine,street,landMark,city,zipCode, profilePic){
    sharedPref?.setString(StringConstant.firstName, firstName.toString().trim());
    sharedPref?.setString(StringConstant.lastName, lastName.toString().trim());
    sharedPref?.setString(StringConstant.number,phone.toString().trim());
    sharedPref?.setString(StringConstant.email, email.toString().trim());
    sharedPref?.setString(StringConstant.addressLine, addressLine.toString().trim());
    sharedPref?.setString(StringConstant.street, street.toString().trim());
    sharedPref?.setString(StringConstant.landMark, landMark.toString().trim());
    sharedPref?.setString(StringConstant.city, city.toString().trim());
    sharedPref?.setString(StringConstant.zipCode, zipCode.toString().trim());
    sharedPref?.setString(StringConstant.profilePic, profilePic);
  }

  getUserDetails(){
    user.value = UserModel(
      id: 1,
      name: Name(firstname: sharedPref?.getString(StringConstant.firstName),lastname: sharedPref?.getString(StringConstant.lastName)),
      phone: sharedPref?.getString(StringConstant.number),
      email: sharedPref?.getString(StringConstant.email),
      address: Address(
          addressLine: sharedPref?.getString(StringConstant.addressLine),
          street: sharedPref?.getString(StringConstant.street),
          landMark: sharedPref?.getString(StringConstant.landMark),
          city: sharedPref?.getString(StringConstant.city),
          zipcode: sharedPref?.getString(StringConstant.zipCode)
      ),
      profilePic: sharedPref?.getString(StringConstant.profilePic)
    );

    addressString.value =
    "${user.value.address!.addressLine != null && user.value.address!.addressLine!.isNotEmpty ? '${user.value.address?.addressLine!.replaceAll(",", "")}, ' : ""}"
    "${user.value.address!.street != null && user.value.address!.street!.isNotEmpty ? "${user.value.address!.street!.replaceAll(",", "")}, " : ""}"
    "${user.value.address!.landMark != null && user.value.address!.landMark!.isNotEmpty ? "${user.value.address!.landMark!.replaceAll(",", "")}, " : ""}"
    "${user.value.address!.city != null && user.value.address!.city!.isNotEmpty ? "${user.value.address!.city!.replaceAll(",", "")} - " : ""}"
    "${user.value.address!.zipcode != null && user.value.address!.zipcode!.isNotEmpty ? user.value.address!.zipcode!.replaceAll(",", "") : ""}";

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
    setUserDetails(
        firstNameController.value.text.trim(), lastNameController.value.text.trim(),
        mobileNumberController.value.text.trim(), emailController.value.text.trim(),
        addressLineController.value.text.trim(), streetController.value.text,
        landMarkController.value.text,
        cityController.value.text.trim(), zipCodeController.value.text.trim(),
        sharedPref?.getString(StringConstant.profilePic)
    );
    getUserDetails();
  }

  updateProfilePic(File value){
    sharedPref?.setString(StringConstant.profilePic, value.path);
    user.value.profilePic = sharedPref?.getString(StringConstant.profilePic);
    user.update((val) { });
  }

}