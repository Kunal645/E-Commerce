import 'package:ecom/constant/text_style.dart';
import 'package:ecom/constant/widgets/flutter_toast.dart';
import 'package:ecom/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:widget_loading/widget_loading.dart';
import '../../constant/color_constant.dart';
import '../../constant/widgets/textfields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/primaryBg.png'),
              fit: BoxFit.cover,
            )),
        child: Stack(
          children: [
            Positioned(
                top: 100.h,
                left: 50.w,
                child: Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 45.sp,
                      fontFamily: 'Poppins-Medium',
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                )),
            Positioned(top: 180.h, right: 0, bottom: 0, child: layerOne()),
            Positioned(top: 220.h, right: 0, bottom: 0,left: 30.h, child: layerSecond()),
            Positioned(top: 260.h, left: 80.w,right: 10, bottom: 0, child: layerThree()),
          ],
        ),
      ),
    );
  }

  Widget layerOne(){
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: layerOneBg,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60.0),
        ),
      ),
    );
  }

  Widget layerSecond(){
    return Container(
      decoration: const BoxDecoration(
        color: layerTwoBg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60.0),
        ),
      ),
    );
  }

  Widget layerThree(){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[

            ///UserName Text
            Text(
              'Email',
              style: TextStyles.k20PoppinsMedium(),
            ),

            ///UserName Field
            SizedBox(
              width: Get.width/1.5,
              child: commonTextField(controller.mailController.value, 'Enter Email')
              /*TextField(
                controller: controller.mailController.value,
                style: TextStyles.k14Regular(),
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Enter User ID or Email',
                  hintStyle: TextStyles.k14Regular(color: hintText),
                ),
              )*/,
            ),
            SizedBox(height: 20.h,),

            ///Password Text
            Text(
              'Password',
              style: TextStyles.k20PoppinsMedium(),
            ),

            ///Password Field
            SizedBox(
              width: Get.width/1.5,
              child: Obx(() {
                  return commonPasswordField(controller.passController.value,controller.showPassword.value,"Enter Password",() => controller.showPassword.value = !controller.showPassword.value);
                  // TextField(
                  //   controller: controller.passController.value,
                  //   style: TextStyles.k14Regular(),
                  //   obscureText: !controller.showPassword.value,
                  //   decoration: InputDecoration(
                  //     border: UnderlineInputBorder(),
                  //     hintText: 'Enter Password',
                  //     hintStyle: TextStyles.k14Regular(color: hintText),
                  //     suffixIcon: InkWell(
                  //       onTap: (){
                  //         controller.showPassword.value = !controller.showPassword.value;
                  //       },
                  //         child: Icon(!controller.showPassword.value ? Icons.visibility : Icons.visibility_off)
                  //     )
                  //   ),
                  // );
                }
              ),
            ),
            SizedBox(height: 10.h,),

            ///Forgot Password
            InkWell(
              onTap: ()=> forgotPasswordDialog(),
              child: Container(
                width: Get.width/1.5,
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgot Password',
                  style: TextStyle(
                      color: forgotPasswordText,
                      fontSize: 15.sp,
                      fontFamily: 'Poppins-Medium',
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(height: 25.h,),

            ///SignIn Button
            Obx(() {
                return GestureDetector(
                  onTap: (){
                    if(controller.mailController.value.text.isNotEmpty && controller.passController.value.text.isNotEmpty){
                      controller.singIn();
                    }
                    else{
                      if(controller.mailController.value.text.isEmpty && controller.passController.value.text.isEmpty){
                        flutterToast("Enter your credentials");
                      }
                      else if(controller.mailController.value.text.isEmpty){
                        flutterToast("Enter your mail");
                      }
                      else{
                        flutterToast("Enter your password");
                      }
                    }
                  },
                  child: Container(
                    width: Get.width/1.5,
                    height: 40.h,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: signInButton,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: controller.isLoading.value
                    ? CircularWidgetLoading(
                      loading: true,
                        padding: EdgeInsets.all(15.w),
                        dotColor: Colors.white,
                        // animatedSize: true,
                        dotRadius: 4,
                        dotCount: 4,
                        rollingDuration: 0.8,
                        child: Container()
                    )
                    : Text(
                      'Sign In',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontFamily: 'Poppins-Medium',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                );
            }),
            SizedBox(height: 20.h,),

            ///Don't have account
            InkWell(
              onTap: () => registerDialog(),
              child: Container(
                width: Get.width/1.5,
                alignment: Alignment.center,
                child: Text("Don't have account ?",
                  style: TextStyle(
                    color: forgotPasswordText,
                    fontSize: 15.sp,
                    fontFamily: 'Poppins-Medium',
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h,),

            ///OR
            SizedBox(
              width: Get.width/1.5,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 0.5,
                      color: inputBorder,
                    ),
                  ),
                  SizedBox(width: 5.w,),
                  Text(
                    'or',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'Poppins-Regular',
                        color: hintText),
                  ),
                  SizedBox(width: 5.w,),
                  Expanded(
                    child: Container(
                      height: 0.5,
                      color: inputBorder,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h,),

            ///SignIn with Google
            InkWell(
              onTap: (){
                controller.signInWithGoogle();
              },
              child: Container(
                width: Get.width/1.5,
                decoration: BoxDecoration(
                    border: Border.all(color: signInBox),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 48.sp,
                      margin: EdgeInsets.only(right: 10.w),
                      child: Image.asset(
                        'assets/images/icon_google.png',
                        width: 20.w,
                        height: 21.h,
                      ),
                    ),
                    Text('Sign In with Google', style: TextStyle(
                        color: forgotPasswordText,
                        fontSize: 15.sp,
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.w600),)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  registerDialog(){
    showDialog(
        context: context,
        builder: (context){
          return Dialog(
            backgroundColor: Colors.white,
            elevation: 0,
            child: ListView(
              padding: EdgeInsets.all(30.w),
              shrinkWrap: true,
              children: [
                Text('Full Name',  style: TextStyle(
                    color: forgotPasswordText,
                    fontSize: 18.sp,
                    fontFamily: 'Poppins-Medium',
                    fontWeight: FontWeight.w600
                ),),
                commonTextField(controller.nameController.value, "Enter full name"),
                SizedBox(height: 10.h),
                Text('Email',  style: TextStyle(
                    color: forgotPasswordText,
                    fontSize: 18.sp,
                    fontFamily: 'Poppins-Medium',
                    fontWeight: FontWeight.w600
                ),),
                commonTextField(controller.mailController.value, "Enter Email"),
                SizedBox(height: 10.h),
                Text('Password',  style: TextStyle(
                    color: forgotPasswordText,
                    fontSize: 18.sp,
                    fontFamily: 'Poppins-Medium',
                    fontWeight: FontWeight.w600
                ),),
                Obx(() {
                    return commonPasswordField(controller.passController.value, controller.showPassword.value,"Enter Password",()=> controller.showPassword.value = !controller.showPassword.value);
                  }
                ),
                SizedBox(height: 10.h),
                Text('Confirm Password',  style: TextStyle(
                    color: forgotPasswordText,
                    fontSize: 18.sp,
                    fontFamily: 'Poppins-Medium',
                    fontWeight: FontWeight.w600
                ),),
                Obx(() {
                    return commonPasswordField(controller.conPassController.value, controller.showConPassword.value,"Enter Confirm Password",()=> controller.showConPassword.value = !controller.showConPassword.value);
                  }
                ),
                SizedBox(height: 20.h),
                Obx(() {
                  return GestureDetector(
                    onTap: (){
                        if(controller.mailController.value.text.isEmpty){
                          flutterToast("Please enter you mail id");
                        }
                        else if(controller.nameController.value.text.isEmpty){
                          flutterToast("Please enter you full name");
                        }
                        else if(controller.passController.value.text.isEmpty){
                          flutterToast("Please enter you password");
                        }
                        else if (controller.conPassController.value.text.isEmpty){
                          flutterToast("Please enter confirm password");
                        }
                        else if(controller.passController.value.text.trim() != controller.conPassController.value.text.trim()){
                          flutterToast("Your Password and Confirm Password not matched");
                        }
                        else{
                          controller.register();
                        }

                    },
                    child: Container(
                      width: Get.width/1.5,
                      height: 40.h,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: signInButton,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                      child: controller.isLoading.value
                          ? CircularWidgetLoading(
                          loading: true,
                          padding: EdgeInsets.all(15.w),
                          dotColor: Colors.white,
                          // animatedSize: true,
                          dotRadius: 4,
                          dotCount: 4,
                          rollingDuration: 0.8,
                          child: Container()
                      )
                          : Text(
                        'Register',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontFamily: 'Poppins-Medium',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                }),
              ],
            ),
          );
        }
    );
  }

  forgotPasswordDialog(){
    return showDialog(
        context: context,
        builder: (context){
          return Dialog(
            backgroundColor: Colors.white,
            elevation: 0,
            child: ListView(
              padding: EdgeInsets.all(30.w),
              shrinkWrap: true,
              children: [
                Text('Email',  style: TextStyle(
                    color: forgotPasswordText,
                    fontSize: 18.sp,
                    fontFamily: 'Poppins-Medium',
                    fontWeight: FontWeight.w600
                ),),
                commonTextField(controller.mailController.value, "Enter your register email"),
                SizedBox(height: 20.h,),
                GestureDetector(
                  onTap: (){
                    controller.forgotPassword();
                  },
                  child: Container(
                    width: Get.width/1.5,
                    height: 40.h,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: signInButton,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child:controller.isLoading.value
                        ? CircularWidgetLoading(
                        loading: true,
                        padding: EdgeInsets.all(15.w),
                        dotColor: Colors.white,
                        // animatedSize: true,
                        dotRadius: 4,
                        dotCount: 4,
                        rollingDuration: 0.8,
                        child: Container()
                    )
                        : Text(
                      'Continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontFamily: 'Poppins-Medium',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
          );
        }
    );
  }

}
