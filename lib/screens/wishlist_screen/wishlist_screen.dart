import 'package:ecom/controller/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/color_constant.dart';
import '../../constant/text_style.dart';
import '../../controller/cart_controller.dart';
import '../../controller/dashboard_controller.dart';
import '../../model/cart_model.dart';
import '../../model/product_model.dart';
import '../product_details_screen.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  
  WishlistController controller = Get.find();

  @override
  void initState() {
    controller.getWishlist();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.kPrimaryBGColor,
      body: Padding(
        padding: EdgeInsets.only(right: 20.w,left: 20.w,top: 20.h),
        child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25.h,),
                Text('My Wishlist', style: TextStyles.k18Bold()),
                controller.wishlist.value.products != null
                ? Expanded(
                  child:   GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 210.h,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.wishlist.value.products!.length,
                      itemBuilder: (context,index){
                        ProductModel product = controller.wishlist.value.products![index];
                        return Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10.r))
                          ),
                          padding: EdgeInsets.all(10.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: (){
                                  Get.to(() => ProductDetailsScreen(product: product,heroString:product.image.toString() ,));
                                },
                                child: Column(
                                  children: [
                                    Hero(
                                        tag: product.image.toString(),
                                        child: Image.network(product.image.toString(),height: 100.w,)
                                    ),
                                    SizedBox(height: 5.h,),
                                    SizedBox(
                                      height: 30.h,
                                      child: Text(product.title.toString(),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyles.k12Regular(color:ColorConstant.kPrimaryColor)
                                      ),
                                    ),
                                    SizedBox(height: 2.h,),
                                    RatingBarIndicator(
                                        rating: double.parse(product.rating!.rate.toString()),
                                        itemCount: 5,
                                        itemSize: 12.h,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amberAccent,
                                        )),
                                    SizedBox(height: 2.h,),
                                    Text("₹${product.price.toString()}",style: TextStyles.k12Bold()),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  CartModel cartModel = CartModel(
                                      id: 1,
                                      userId: 1,
                                      products: [CartProducts(productId: product.id,quantity: 1)]
                                  );
                                  Get.find<DashboardController>().controllerIndex.value = 1;
                                  await Get.find<CartController>().addToCart(cartModel,product);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xff67C4A7),
                                      borderRadius: BorderRadius.circular(10.r)
                                  ),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(5.w),
                                  margin: EdgeInsets.all(5.w),
                                  height: 30.h,
                                  width: Get.width,
                                  child: GestureDetector(
                                    child: Text('Add to cart',style: TextStyles.k12Bold(color: Colors.white)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                  )
                )
                 : Expanded(child: Center(child: Text('No Items in Wishlist',style: TextStyles.k18Bold(),))),
              ],
            );
          }
        ),
      ),
    );
  }
}
