import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/constant/color_constant.dart';
import 'package:ecom/constant/functions.dart';
import 'package:ecom/constant/widgets/loader.dart';
import 'package:ecom/constant/widgets/photo_view.dart';
import 'package:ecom/controller/user_controller.dart';
import 'package:ecom/model/user_model.dart';
import 'package:ecom/screens/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/text_style.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {

  UserController controller = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: ColorConstant.kPrimaryBGColor,
            height: Get.height,
            width: Get.width,
            padding: EdgeInsets.only(top: 45.h,left: 20.w,right: 20.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('My Profile', style: TextStyles.k18Bold()),
                GestureDetector(
                  onTap: (){
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context){
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom),
                            child: Form(
                              key: _formKey,
                              child: ListView(
                                padding: EdgeInsets.all(15.w),
                                shrinkWrap: true,
                                children: [
                                  SizedBox(height: 10.h,),
                                  Row(
                                    children: [
                                      const Spacer(),
                                      Text('Edit Profile',style: TextStyles.k18Regular(),),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: (){
                                          Get.back();
                                        },
                                        child: Icon(Icons.close,size: 20.h),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20.h,),
                                  commonInputField("First Name",controller.firstNameController.value),
                                  SizedBox(height: 10.h,),
                                  commonInputField("Last Name",controller.lastNameController.value),
                                  SizedBox(height: 10.h,),
                                  TextField(
                                    style: TextStyles.k14Regular(),
                                    controller: controller.mobileNumberController.value,
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      filled: true,
                                      hintStyle: TextStyles.k14Regular(),
                                      hintText: "Mobile Number",
                                      counterText: "",
                                      fillColor: Colors.white70,
                                    ),
                                  ),
                                  SizedBox(height: 10.h,),
                                  commonInputField("Email",controller.emailController.value),
                                  SizedBox(height: 10.h,),
                                  commonInputField("House No., Flat, Apartment, Society",controller.addressLineController.value),
                                  SizedBox(height: 10.h,),
                                  commonInputField("Area, Street, Sector, Village",controller.streetController.value),
                                  SizedBox(height: 10.h,),
                                  commonInputField("Landmark",controller.landMarkController.value),
                                  SizedBox(height: 10.h,),
                                  commonInputField("City",controller.cityController.value),
                                  SizedBox(height: 10.h,),
                                  commonInputField("Zipcode",controller.zipCodeController.value),
                                  SizedBox(height: 20.h,),
                                  GestureDetector(
                                    onTap: (){
                                      if( _formKey.currentState!.validate()){
                                        controller.updateUserData();
                                        Get.back();
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xff67C4A7),
                                          borderRadius: BorderRadius.circular(10.r)
                                      ),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(5.w),
                                      margin: EdgeInsets.all(5.w),
                                      height: 50.h,
                                      width: Get.width,
                                      child: Text('Update',style: TextStyles.k16Bold(color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                    );
                  },
                  child: Container(
                      padding: EdgeInsets.all(7.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.green.withOpacity(0.5)
                      ),
                      child: Text('Edit Profile', style: TextStyles.k12Regular())
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 140.h,
            child: Container(
              height: Get.height,
              width: Get.width,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40.r),topRight: Radius.circular(40.r))
              ),
              child: StreamBuilder(
                  stream: controller.getStream(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if(snapshot.hasData){
                      String? name;
                      Future.microtask(() async {
                        await controller.getUserDetails(UserModel.fromJson(snapshot.data!.data() as Map<String,dynamic>));
                        name = "${controller.user.value.name?.firstname.toString().capitalizeFirst} ${controller.user.value.name?.lastname != null ? controller.user.value.name?.lastname.toString().capitalizeFirst : ""}";
                      });
                      return Obx(() {
                          return Column(
                            children: [
                              SizedBox(height: 45.h,),
                              Text(name ?? "",style: TextStyles.k16Bold(),textAlign: TextAlign.center),
                              SizedBox(height: 10.h,),
                              const Divider(),
                              SizedBox(height: 10.h,),
                              Visibility(
                                visible: controller.user.value.phone != null && controller.user.value.phone!.isNotEmpty,
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                                  child: Container(
                                    padding: EdgeInsets.all(10.w),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.phone),
                                        SizedBox(width: 10.w,),
                                        Text(controller.user.value.phone ?? "")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h,),
                              Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                                child: Container(
                                  padding: EdgeInsets.all(10.w),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.mail),
                                      SizedBox(width: 10.w,),
                                      Text(controller.user.value.email.toString())
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h,),
                              Visibility(
                                visible: controller.addressString.value.isNotEmpty,
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                                  child: Container(
                                    padding: EdgeInsets.all(10.w),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.location_on),
                                        SizedBox(width: 10.w,),
                                        Expanded(child: Text(controller.addressString.value))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h,),
                              ElevatedButton(
                                  onPressed: () async {
                                    final SharedPreferences pref = await SharedPreferences.getInstance();
                                    pref.clear();
                                    await FirebaseAuth.instance.signOut();
                                    Get.offAll(() => const LoginScreen());
                                  },
                                  child: const Text("Logout")
                              )
                            ],
                          );
                        }
                      );
                    }
                    else{
                      return const Center(child: CircularProgressIndicator());
                    }
                  }
              ),
            ),
          ),
          Positioned(
            top: 90.h,
            left: MediaQuery.sizeOf(context).width / 2.8,
            child:  Stack(
              children: [
                Obx(() {
                  return GestureDetector(
                    onTap: (){
                      if(controller.user.value.profilePic != null &&  controller.user.value.profilePic!.isNotEmpty){
                        Get.to(() => FullScreenPhotoView(url: controller.user.value.profilePic.toString()));
                      }
                      else{
                        uploadImageDialog(context);
                      }

                    },
                    child: Container(
                      height: 110.w,
                      width: 110.w,
                      padding: EdgeInsets.all(1.r),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: ColorConstant.kPrimaryColor),
                          color: controller.user.value.profilePic != null &&  controller.user.value.profilePic!.isNotEmpty ? Colors.transparent : Colors.grey.shade300
                      ),
                      child: controller.user.value.profilePic != null &&  controller.user.value.profilePic!.isNotEmpty
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(60.r),
                        child: Image.network(controller.user.value.profilePic.toString(), fit: BoxFit.cover,),
                      )
                          : Container(),
                    ),
                  );
                }),
                Positioned(
                  bottom: 9.h,
                  right: 0,
                  left: 80.w,
                  child: GestureDetector(
                    onTap: (){
                      uploadImageDialog(context);
                    },
                    child: Container(
                      height: 20.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: ColorConstant.kPrimaryColor),
                        color: Colors.white,
                      ),
                      child: Icon(Icons.edit,size: 10.h),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }

  uploadImageDialog(context){
    return  showModalBottomSheet(
        context: context,
        builder: (context){
          return SizedBox(
            height: 150.h,
            width: Get.width,
            child: Column(
              children: [
                const Spacer(),
                Text('Select Image with',style: TextStyles.k16Regular(),),
                const Spacer(),
                Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        Utils(context).startLoading();
                        var imageResponse = await Functions().uploadImage(ImageSource.camera);
                        if(imageResponse != null){
                          controller.imageFile.value = imageResponse;
                          controller.updateProfilePic(controller.imageFile.value);
                        }
                        Utils(context).stopLoading();
                        Get.back();
                        print(controller.imageFile.value);
                      },
                      child: Column(
                        children: [
                          Icon(Icons.camera_alt_outlined,size: 30.h,),
                          SizedBox(height: 5.h,),
                          Text('Camera',style: TextStyles.k12Regular(),)
                        ],
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        var imageResponse = await Functions().uploadImage(ImageSource.gallery);
                        if(imageResponse != null){
                          Utils(context).startLoading();
                          controller.imageFile.value = imageResponse;
                          await controller.updateProfilePic(controller.imageFile.value);
                          Utils(context).stopLoading();
                        }
                        Get.back();
                        print(controller.imageFile.value);
                      },
                      child: Column(
                        children: [
                          Icon(Icons.photo_library_outlined,size: 30.h,),
                          SizedBox(height: 5.h,),
                          Text('Gallery',style: TextStyles.k12Regular(),)
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const Spacer(),
              ],
            ),
          );
        }
    );
  }

  commonInputField(String hint, controller){
    return TextFormField(
      validator: (value){
        if(value == null || value.isEmpty){
          return '$hint is empty';
        }
        else{
          return null;
        }
      },
      style: TextStyles.k14Regular(),
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        hintStyle: TextStyles.k14Regular(),
        hintText: hint,
        fillColor: Colors.white70,
      ),
    );
  }

}
