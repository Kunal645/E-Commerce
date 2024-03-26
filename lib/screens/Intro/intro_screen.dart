import 'package:ecom/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/color_constant.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        headerBackgroundColor: ColorConstant.kPrimaryBGColor,
        finishButtonText: 'Continue',
        finishButtonStyle: const FinishButtonStyle(
          backgroundColor: Color(0xff67C4A7),
        ),
        onFinish: (){
          Get.to(()=> const LoginScreen());
        },
        trailing: const Text(''),
        pageBackgroundColor: ColorConstant.kPrimaryBGColor,
        // indicatorAbove: true,
        skipTextButton: const Text(''),
        imageHorizontalOffset: 0,
        imageVerticalOffset: 0,
        middle: Text('E - Commerce',style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.w500,
            color: Colors.deepPurple,
            fontStyle: FontStyle.italic
        )),
        background: [
          Container(),
          Container(),
          Container(),
        ],
        totalPage: 3,
        speed: 1.8,
        pageBodies: [
          Column(
            children: [
              Image.asset('assets/images/7793690.png',
                height: 500.h,
                // alignment: Alignment.centerLeft,
                fit: BoxFit.cover,
              ),
              Center(child: Text('Ready to Finding\nNew Excitements',style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w500,
                color: Colors.deepPurple,
                fontStyle: FontStyle.italic
              ),)),
              const Spacer(),
            ],
          ),
          Column(
            children: [
              Image.asset('assets/images/7768814.png',
                height: 500.h,
                fit: BoxFit.cover,
              ),
              Center(child: Text('Ready to Finding\nExcitements Offers',textAlign: TextAlign.center,style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.deepPurple,
                  fontStyle: FontStyle.italic
              ),)),
              const Spacer(),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 100.h,),
              Image.asset('assets/images/7813399.png',
                height: 340.h,
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 30.h,),
              Center(child: Text("Let's Go...",textAlign: TextAlign.center,style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.deepPurple,
                  fontStyle: FontStyle.italic
              ),)),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
