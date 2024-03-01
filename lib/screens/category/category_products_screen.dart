import 'package:ecom/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/color_constant.dart';
import '../../constant/text_style.dart';
import '../../controller/cart_controller.dart';
import '../../controller/dashboard_controller.dart';
import '../../model/cart_model.dart';
import '../../model/product_model.dart';
import '../product_details_screen.dart';

class CategoryProductScreen extends StatefulWidget {
  final String? categoryName;
  const CategoryProductScreen({required this.categoryName,super.key});

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {

  CategoryController controller = Get.find();

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
              SizedBox(height: 20.h,),
              Row(
                children: [
                  InkWell(
                      onTap : (){Get.back();},
                      child: const Icon(Icons.arrow_back)
                  ),
                  SizedBox(width: 10.w,),
                  Text(widget.categoryName.toString(), style: TextStyles.k18Bold()),
                ],
              ),
              SizedBox(height: 10.h,),
              controller.products.isNotEmpty
                  ? Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 196.h,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h
                      ),
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 10.h,top: 10.h),
                      itemCount: controller.products.length,
                      itemBuilder: (context,index){
                        ProductModel product = controller.products[index];
                        return Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10.r))
                          ),
                          padding: EdgeInsets.all(10.w),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Get.to(() => ProductDetailsScreen(product: product,heroString: "",));
                                },
                                child: Column(
                                  children: [
                                    Image.network(product.image.toString(),height: 100.w,),
                                    SizedBox(height: 5.h,),
                                    Text(product.title.toString(),overflow: TextOverflow.ellipsis,),
                                    SizedBox(height: 5.h,),
                                    Text("₹${product.price.toString()}",style: TextStyles.k12Bold()),
                                    SizedBox(height: 5.h,),
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
