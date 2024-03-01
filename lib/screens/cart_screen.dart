import 'package:ecom/constant/color_constant.dart';
import 'package:ecom/constant/widgets/loader.dart';
import 'package:ecom/controller/cart_controller.dart';
import 'package:ecom/model/product_model.dart';
import 'package:ecom/screens/checkout/checkout_screen.dart';
import 'package:ecom/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constant/text_style.dart';
import '../controller/dashboard_controller.dart';
import '../model/cart_model.dart';

class CartScreen extends StatefulWidget {
  final bool flag;
  const CartScreen({required this.flag,super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  CartController controller = Get.find();
  @override
  void initState() {
    Future.microtask(() async {
    if(widget.flag){

    }
    await controller.getCart();
    controller.totalCount();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.kPrimaryBGColor,
      body: Padding(
        padding: EdgeInsets.only(right: 20.w,left: 20.w,top: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.h,),
            Text('My Cart', style: TextStyles.k18Bold()),
            Expanded(
              child: Obx(() {
                return controller.cartList.isNotEmpty
                  ? SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context,index){return SizedBox(height: 10.h,);},
                            itemCount: controller.cartList.length,
                            itemBuilder: (context,index){
                              ProductModel product = controller.cartList[index];
                              return Dismissible(
                                key: UniqueKey(),
                                background: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.all(Radius.circular(10.r))
                                  ),
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.all(20.w),
                                  child: Text('Remove',style: TextStyles.k16Bold()),
                                ),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction){
                                  controller.removeItem(index,product.id);
                                },
                                child: GestureDetector(
                                  onTap: (){
                                    Get.to(() => ProductDetailsScreen(product: product, heroString: ""));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(10.w),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(10.r))
                                    ),
                                    child: Row(
                                      children: [
                                        Image.network(product.image.toString(),height:70.h,width: 60.w,),
                                        SizedBox(width: 15.w,),
                                        Expanded(
                                          child: ListView(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(child: Text(product.title.toString(),style: TextStyles.k14Bold(color: ColorConstant.kPrimaryColor),maxLines: 2)),
                                                  SizedBox(width: 5.w,),
                                                  InkWell(
                                                    onTap: (){
                                                      controller.removeItem(index,product.id);
                                                    },
                                                    child: Container(
                                                      height: 20.w,
                                                      width: 20.w,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(color: Colors.grey)
                                                      ),
                                                      alignment: Alignment.center,
                                                      child: Icon(Icons.delete,size: 12.h),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10.w,),
                                                ],
                                              ),
                                              Text(product.category.toString().capitalizeFirst.toString(),style: TextStyles.k12Bold()),
                                              RatingBarIndicator(
                                                  rating: double.parse(product.rating!.rate.toString()),
                                                  itemCount: 5,
                                                  itemSize: 12.h,
                                                  itemBuilder: (context, _) => const Icon(
                                                    Icons.star,
                                                    color: Colors.amberAccent,
                                                  )),
                                              SizedBox(height: 3.h,),
                                              Obx(() {
                                                return Row(
                                                  children: [
                                                    Text("₹${controller.countItemValue(product.price.toString(),controller.cart.value.products![index].quantity.toString())} (${product.price.toString()})",style: TextStyles.k14Bold()),
                                                    const Spacer(),
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () async {
                                                            Utils(context).startLoading();
                                                            await controller.decrementItem(index,product.id);
                                                            Utils(context).stopLoading();
                                                          },
                                                          child: Container(
                                                            height: 20.w,
                                                            width: 20.w,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                border: Border.all(color: Colors.grey)
                                                            ),
                                                            alignment: Alignment.center,
                                                            child: Icon(Icons.remove,size: 12.h),
                                                          ),
                                                        ),
                                                        SizedBox(width: 5.w,),
                                                        Text(controller.cart.value.products![index].quantity.toString()),
                                                        SizedBox(width: 5.w,),
                                                        InkWell(
                                                          onTap: () async {
                                                            Utils(context).startLoading();
                                                            await controller.incrementItem(index,product.id);
                                                            Utils(context).stopLoading();
                                                          },
                                                          child: Container(
                                                            height: 20.w,
                                                            width: 20.w,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                border: Border.all(color: Colors.grey)
                                                            ),
                                                            alignment: Alignment.center,
                                                            child: Icon(Icons.add,size: 12.h),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(width: 10.w,)
                                                  ],
                                                );
                                              }
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                        ),
                        SizedBox(height: 10.h,),
                        Container(
                          height: 220.h,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10.r))
                          ),
                          child: ListView(
                            padding: EdgeInsets.all(10.w),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              Text('Recommendation based on items in your cart',style: TextStyles.k16Bold()),
                              SizedBox(
                                height: 190.h,
                                child: ListView.separated(
                                  separatorBuilder: (context,index){return SizedBox(width: 5.w,);},
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(bottom: 10.h,top: 5.h),
                                    itemCount: controller.addOnProducts.length,
                                    itemBuilder: (context,index){
                                      return Container(
                                        width: 115.w,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(Radius.circular(10.r))
                                        ),
                                        padding: EdgeInsets.only(top: 5.h,bottom: 5.h,left: 5.w),
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onTap: (){
                                                Get.to(() => ProductDetailsScreen(product: controller.addOnProducts[index],heroString: "",));
                                              },
                                              child: Column(
                                                children: [
                                                  Image.network(controller.addOnProducts[index].image.toString(),height: 60.w,),
                                                  SizedBox(height: 2.h,),
                                                  Text(controller.addOnProducts[index].title.toString(),overflow: TextOverflow.ellipsis,style: TextStyles.k12Bold(color: ColorConstant.kPrimaryColor),maxLines: 2,textAlign: TextAlign.center),
                                                  SizedBox(height: 2.h,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      RatingBarIndicator(
                                                          rating: double.parse(controller.addOnProducts[index].rating!.rate.toString()),
                                                          itemCount: 5,
                                                          itemSize: 14.h,
                                                          itemBuilder: (context, _) => const Icon(
                                                            Icons.star,
                                                            color: Colors.amberAccent,
                                                          )),
                                                      SizedBox(width: 2.w,),
                                                      // Container(
                                                      //   height: 10.h,
                                                      //   padding: EdgeInsets.zero,
                                                      //     // color: Colors.red,
                                                      //     child: Text(controller.addOnProducts[index].rating!.count.toString(),style: TextStyles.k10Bold(color: Colors.grey))),
                                                    ],
                                                  ),
                                                  // RatingBar(
                                                  //     ratingWidget: RatingWidget(empty: Icon(Icons.star),full: Icon(Icons.star),half: Icon(Icons.star),),
                                                  //     onRatingUpdate: (value){
                                                  //     }
                                                  // ),
                                                  Text("₹${controller.addOnProducts[index].price.toString()}",style: TextStyles.k12Bold()),
                                                  SizedBox(height: 2.h,),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                CartModel cartModel = CartModel(
                                                    id: 1,
                                                    userId: 1,
                                                    products: [CartProducts(productId: controller.addOnProducts[index].id,quantity: 1)]
                                                );
                                                Get.find<DashboardController>().controllerIndex.value = 1;
                                                await Get.find<CartController>().addToCart(cartModel,controller.addOnProducts[index]);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: const Color(0xff67C4A7),
                                                    borderRadius: BorderRadius.circular(10.r)
                                                ),
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(5.w),
                                                margin: EdgeInsets.all(5.w),
                                                height: 25.h,
                                                width: Get.width,
                                                child: GestureDetector(
                                                  child: Text('Add to cart',style: TextStyles.k10Bold(color: Colors.white)),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h,),
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
                                    Text('₹${controller.total.toStringAsFixed(2).toString()}',style: TextStyles.k14Bold()),
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
                                    Text('₹${controller.grandTotal.toStringAsFixed(2).toString()}',style: TextStyles.k14Bold()),
                                  ],
                                ),
                                SizedBox(height: 5.h,),
                              ],
                            );
                          }
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        InkWell(
                          onTap: (){
                            Get.to(() => const CheckoutScreen());
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
                              child: Text('Checkout',style: TextStyles.k16Bold(color: Colors.white)),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h,),
                      ],
                    ),
                  )
                    : Center(child: Text("You cart is empty",style: TextStyles.k16Regular(),));
              }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
