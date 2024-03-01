import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles{

  static TextStyle k8Regular(){
    return TextStyle(fontSize: 8.sp);
  }

  static TextStyle k10Regular({Color? color}){
    return TextStyle(fontSize: 10.sp,color: color ?? Colors.black,);
  }

  static TextStyle k10Bold({Color? color}){
    return TextStyle(fontSize: 10.sp,color: color ?? Colors.black,fontWeight: FontWeight.bold);
  }

  static TextStyle k12Regular({Color? color}){
    return TextStyle(fontSize: 12.sp,color: color ?? Colors.black);
  }

  static TextStyle k12Bold({Color? color}){
    return TextStyle(fontSize: 12.sp,color: color ?? Colors.black,fontWeight: FontWeight.bold);
  }

  static TextStyle k14Bold({Color? color}){
    return TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold,color: color ?? Colors.black);
  }

  static TextStyle k14Regular(){
    return TextStyle(fontSize: 14.sp);
  }

  static TextStyle k16Bold({Color? color}){
    return TextStyle(fontSize: 16.sp,color: color ?? Colors.black,fontWeight: FontWeight.bold);
  }

  static TextStyle k16Regular(){
    return TextStyle(fontSize: 16.sp);
  }

  static TextStyle k18Regular(){
    return TextStyle(fontSize: 18.sp);
  }

  static TextStyle k18Bold(){
    return TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold);
  }

  static TextStyle k20Bold(){
    return TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold);
  }

  static TextStyle k22Bold(){
    return TextStyle(fontSize: 122.sp,fontWeight: FontWeight.bold);
  }

}