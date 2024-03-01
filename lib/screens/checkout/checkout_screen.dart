import 'package:ecom/controller/cart_controller.dart';
import 'package:ecom/controller/checkout_controller.dart';
import 'package:ecom/controller/dashboard_controller.dart';
import 'package:ecom/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../constant/color_constant.dart';
import '../../constant/text_style.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  CheckoutController controller = Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.kPrimaryBGColor,
      body: Obx(() {
          return Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                SizedBox(height: 25.h,),
                Row(
                  children: [
                    InkWell(
                        onTap : (){Get.back();},
                        child: const Icon(Icons.arrow_back)
                    ),
                    SizedBox(width: 10.w,),
                    Text('Checkout', style: TextStyles.k18Bold()),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Text('Select Address',style: TextStyles.k14Bold()),
                      SizedBox(height: 20.h,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 20.w,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.redAccent),
                              shape: BoxShape.circle
                            ),
                            padding: EdgeInsets.all(5.r),
                            child: Container(
                              height: 10.h,
                              decoration: const BoxDecoration(
                                  color: Colors.redAccent,
                                  shape: BoxShape.circle
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Home address',style: TextStyles.k14Bold()),
                                SizedBox(height: 5.h,),
                                Container(
                                  padding: EdgeInsets.all(10.w),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        // border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10.r)
                                    ),
                                    child: Text(Get.find<UserController>().addressString.value/*'125, Shree Nand Park, Near Iscon Temple, Iscon cross road, Ahmedabad - 380001'*/,
                                        style: TextStyles.k14Regular()
                                    )
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      InkWell(onTap: (){}, child:Text('+ Add new address',style: TextStyles.k14Bold(color: Colors.red))),
                      SizedBox(height: 20.h,),
                      Text('Payment method',style: TextStyles.k14Bold()),
                      SizedBox(height: 20.h,),
                      GestureDetector(
                        onTap: (){
                          controller.paymentMethod.value = 0;
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 20.w,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.redAccent),
                                  shape: BoxShape.circle
                              ),
                              padding: EdgeInsets.all(5.w),
                              child: Container(
                                height: 10.h,
                                decoration: BoxDecoration(
                                    color: controller.paymentMethod.value == 0 ? Colors.redAccent : Colors.transparent,
                                    shape: BoxShape.circle
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w,),
                            Text('Cash on Delivey',style: TextStyles.k14Bold()),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      GestureDetector(
                        onTap: (){
                          controller.paymentMethod.value = 1;
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 20.w,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.redAccent),
                                  shape: BoxShape.circle
                              ),
                              padding: EdgeInsets.all(5.w),
                              child: Container(
                                height: 10.h,
                                decoration: BoxDecoration(
                                    color: controller.paymentMethod.value == 1 ? Colors.redAccent : Colors.transparent,
                                    shape: BoxShape.circle
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Credit Card',style: TextStyles.k14Bold()),
                                  SizedBox(height: 10.h,),
                                  controller.paymentMethod.value == 1
                                  ? Container(
                                      padding: EdgeInsets.all(10.w),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          // border: Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(10.r)
                                      ),
                                    child: Obx(() {
                                        return Column(
                                          children: [
                                            CreditCardWidget(
                                                cardBgColor: const Color(0xff363636),
                                                cardNumber: controller.cardNumber.value,
                                                expiryDate: controller.expiryDate.value,
                                                isHolderNameVisible: true,
                                                isChipVisible: true,
                                                chipColor: Colors.grey,
                                                cardHolderName: controller.cardHolderName.value,
                                                labelCardHolder: controller.cardHolderName.value,
                                                cvvCode: controller.cvvCode.value,
                                                showBackView: controller.isCvvFocused.value,
                                                onCreditCardWidgetChange:  (CreditCardBrand creditCardBrand) {}
                                            ),
                                            CreditCardForm(
                                              obscureCvv: true,
                                              obscureNumber: true,
                                              cardNumber: controller.cardNumber.value,
                                              cvvCode: controller.cvvCode.value,
                                              isHolderNameVisible: true,
                                              isCardNumberVisible: true,
                                              isExpiryDateVisible: true,
                                              // isHolderNameVisible: true,
                                              cardHolderName: controller.cardHolderName.value,
                                              expiryDate: controller.expiryDate.value,
                                              inputConfiguration: const InputConfiguration(
                                                cardNumberDecoration: InputDecoration(
                                                  labelText: 'Number',
                                                  hintText: 'XXXX XXXX XXXX XXXX',
                                                ),
                                                expiryDateDecoration: InputDecoration(
                                                  labelText: 'Expired Date',
                                                  hintText: 'XX/XX',
                                                ),
                                                cvvCodeDecoration: InputDecoration(
                                                  labelText: 'CVV',
                                                  hintText: 'XXX',
                                                ),
                                                cardHolderDecoration: InputDecoration(
                                                  labelText: 'Card Holder',
                                                ),
                                              ),
                                              onCreditCardModelChange: (model){
                                                print(model);
                                                controller.cardHolderName.value = model.cardHolderName;
                                                controller.cardNumber.value = model.cardNumber;
                                                controller.expiryDate.value = model.expiryDate;
                                                controller.cvvCode.value = model.cvvCode;
                                                controller.isCvvFocused.value = model.isCvvFocused;
                                              },
                                              formKey: formKey,
                                            ),
                                          ],
                                        );
                                      }
                                    ),
                                  )
                                      : Container(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Container(
                        padding: EdgeInsets.all(15.w),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10.r))
                        ),
                        child: Obx(() {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5.h,),
                              Text("Order Summary",style: TextStyles.k16Bold()),
                              SizedBox(height: 15.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Sub Total',style: TextStyles.k14Bold()),
                                  Text('₹${Get.find<CartController>().total.toStringAsFixed(2).toString()}',style: TextStyles.k14Bold()),
                                ],
                              ),
                              SizedBox(height: 10.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Delivery',style: TextStyles.k14Bold()),
                                  Text('₹50',style: TextStyles.k14Bold()),
                                ],
                              ),
                              SizedBox(height: 10.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Discount',style: TextStyles.k14Bold()),
                                  Text('- ₹100',style: TextStyles.k14Bold()),
                                ],
                              ),
                              SizedBox(height: 5.h,),
                              const Divider(),
                              SizedBox(height: 5.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total',style: TextStyles.k14Bold()),
                                  Text('₹${Get.find<CartController>().grandTotal.toStringAsFixed(2).toString()}',style: TextStyles.k14Bold()),
                                ],
                              ),
                              SizedBox(height: 5.h,),
                            ],
                          );
                        }
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      InkWell(
                        onTap: (){
                          // Get.to(() => CheckoutScreen());
                          orderDialog(context);
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
                          child: GestureDetector(
                            child: Text('Place an order',style: TextStyles.k16Bold(color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  orderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.all(20.w),
          backgroundColor: Colors.white,
          clipBehavior: Clip.none,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Congratulations...',style: TextStyles.k18Bold(),),
                Lottie.asset("assets/images/lottie_success.json"),
                Text('Successfully Placed Order',style: TextStyles.k18Bold(),),
                SizedBox(height: 20.h,),
                InkWell(
                  onTap: (){
                    Get.back();
                    Get.back();
                    Get.find<DashboardController>().controllerIndex.value = 0;
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
                    width: Get.width / 1.5,
                    child: GestureDetector(
                      child: Text('Continue',style: TextStyles.k16Bold(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
