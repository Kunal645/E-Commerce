import 'package:ecom/model/product_model.dart';
import 'package:ecom/screens/AR/earth_ar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:model_viewer_plus/model_viewer_plus.dart';
// import 'package:o3d/o3d.dart';
import '../constant/text_style.dart';
import '../controller/cart_controller.dart';
import '../controller/dashboard_controller.dart';
import '../controller/wishlist_controller.dart';
import '../model/cart_model.dart';
import 'AR/ar_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;
  final String heroString;
  const ProductDetailsScreen({required this.product,required this.heroString,super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  bool? flag = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: ListView(
            padding: EdgeInsets.all(20.w),
            children: [
              SizedBox(height: 25.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap : (){Get.back();},
                      child: const Icon(Icons.arrow_back)
                  ),
                  InkWell(
                      onTap : (){
                        if(Get.find<WishlistController>().wishlist.value.products != null && Get.find<WishlistController>().wishlist.value.products!.any((element) => element.id == widget.product.id)){
                          Get.find<WishlistController>().removeWishList(widget.product, context);
                          Get.find<WishlistController>().getWishlist();
                          setState(() {
                            flag = false;
                          });
                        }
                        else{
                          Get.find<WishlistController>().addWishlist(widget.product,context);
                          Get.find<WishlistController>().getWishlist();
                          setState(() {
                            flag = true;
                          });
                        }
                      },
                      child: flag == true
                          ? const Icon(Icons.favorite,color: Colors.red,)
                          : Get.find<WishlistController>().wishlist.value.products != null
                          ? Get.find<WishlistController>().wishlist.value.products!.any((element) => element.id == widget.product.id)
                          ? const Icon(Icons.favorite,color: Colors.red,)  : const Icon(Icons.favorite_border)
                          : const Icon(Icons.favorite_border)
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child:/* widget.product.id != 14
                ?*/ Hero(
                    tag: widget.heroString,
                    child: Image.network(widget.product.image.toString(),height: 300.h,)
                )
               /* : SizedBox(
                    height: 300.h,
                    child: ModelViewer(
                        src: 'assets/images/tv.glb',
                      autoRotate: false,
                      cameraControls: true,
                      disableZoom: true,

                      // relatedJs: js,
                      // innerModelViewerHtml: _html2,
                      // overwriteNodeValidatorBuilder: myNodeValidatorBuilder,
                      // backgroundColor: Colors.red,
                      alt: 'A 3D model of an astronaut',
                    )
                ),*/
              ),
              SizedBox(height: 30.h,),
              // InkWell(
              //   onTap: (){
              //     Get.to(()=> Earth_AR());
              //   },
              //   child: Container(
              //     decoration: BoxDecoration(
              //         color: const Color(0xff67C4A7),
              //         borderRadius: BorderRadius.circular(10.r)
              //     ),
              //     alignment: Alignment.center,
              //     padding: EdgeInsets.all(5.w),
              //     height: 40.h,
              //     child: GestureDetector(
              //       child: Text('View in 360',style: TextStyles.k12Bold(color: Colors.white)),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 30.h,),
              Row(
                children: [
                  RatingBarIndicator(
                      rating: double.parse(widget.product.rating!.rate.toString()),
                      itemCount: 5,
                      itemSize: 20.h,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amberAccent,
                      )),
                  SizedBox(width: 5.w,),
                  Text(widget.product.rating!.rate.toString(),style: TextStyles.k16Bold(),),
                  SizedBox(width: 10.w,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.grey.shade300
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
                    child: Text("${widget.product.rating!.count.toString()} Reviews",style: TextStyles.k14Bold()),
                  )
                ],
              ),
              SizedBox(height: 10.h,),
              Text("${widget.product.title.toString()} - ${widget.product.category.toString().capitalizeFirst.toString()}",style: TextStyles.k14Bold()),
              SizedBox(height: 10.h,),
              Text(widget.product.description.toString(),style: TextStyles.k14Regular(),textAlign: TextAlign.justify),
              SizedBox(height: 20.h,),
              SizedBox(
                height: 40.h,
                child: Column(
                  children: [
                    const Spacer(),
                    Row(
                       children: [
                         Expanded(
                           child: InkWell(
                             onTap: () async {
                               CartModel cartModel = CartModel(
                                   id: 1,
                                   userId: 1,
                                   products: [CartProducts(productId: widget.product.id,quantity: 1)]
                               );
                               Get.back();
                               Get.find<DashboardController>().controllerIndex.value = 1;
                               await Get.find<CartController>().addToCart(cartModel,widget.product);
                             },
                             child: Container(
                               decoration: BoxDecoration(
                                   color: const Color(0xff67C4A7),
                                   borderRadius: BorderRadius.circular(10.r)
                               ),
                               alignment: Alignment.center,
                               padding: EdgeInsets.all(5.w),
                               height: 40.h,
                               child: GestureDetector(
                                 child: Text('Add to cart',style: TextStyles.k12Bold(color: Colors.white)),
                               ),
                             ),
                           ),
                         ),
                         SizedBox(width: 10.w,),
                         Expanded(
                           child: Container(
                             decoration: BoxDecoration(
                                 color: const Color(0xff67C4A7),
                                 borderRadius: BorderRadius.circular(10.r)
                             ),
                             alignment: Alignment.center,
                             padding: EdgeInsets.all(5.w),
                             height: 40.h,
                             child: GestureDetector(
                               child: Text('Buy Now',style: TextStyles.k12Bold(color: Colors.white)),
                             ),
                           ),
                         )
                       ],
                    ),
                  ],
                ),
              )
            ],
          ),
      ),
    );
  }
}
