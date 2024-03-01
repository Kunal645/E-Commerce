import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom/constant/color_constant.dart';
import 'package:ecom/constant/text_style.dart';
import 'package:ecom/constant/widgets/loader.dart';
import 'package:ecom/controller/cart_controller.dart';
import 'package:ecom/controller/category_controller.dart';
import 'package:ecom/controller/homescreen_controller.dart';
import 'package:ecom/controller/user_controller.dart';
import 'package:ecom/model/cart_model.dart';
import 'package:ecom/model/product_model.dart';
import 'package:ecom/screens/category/category_products_screen.dart';
import 'package:ecom/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/dashboard_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeScreenController controller = Get.find();
  UserController userController = Get.find();

  int current = 0;
  final CarouselController carouselController = CarouselController();

  @override
  void initState() {
    userController.getUser();
    controller.getProduct();
    super.initState();
  }

  final List<String> imgList = [
    '',
    '',
    ''
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        return Scaffold(
          backgroundColor: ColorConstant.kPrimaryBGColor,
          body: Padding(
            padding: EdgeInsets.only(right: 20.w,left: 20.w,top: 20.h),
            child: Column(
              children: [
                SizedBox(height: 25.h,),
                Row(
                  children: [
                    userController.user.value.name != null
                        ? Text("Hello, ${userController.user.value.name!.firstname.toString().capitalizeFirst}",
                      style: TextStyles.k18Bold(),
                    ) : const CircularProgressIndicator(),
                    const Spacer(),
                    GestureDetector(
                        onTap: (){
                          Get.find<DashboardController>().controllerIndex.value = 1;
                        },
                        child: const Icon(Icons.shopping_cart_outlined)),
                    SizedBox(width: 20.w,),
                    const Icon(Icons.notifications_active)
                  ],
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(bottom: 20.h,top: 20.h),
                    children: [
                      CarouselSlider(
                          items: [
                            Image.asset("assets/images/banner1.png",),
                            Image.asset("assets/images/banner2.jpg",),
                            Image.asset("assets/images/banner3.jpg",),
                          ],
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                            autoPlay: true,
                            // aspectRatio: 16 / 9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            // enableInfiniteScroll: true,
                            autoPlayAnimationDuration: const Duration(milliseconds: 800),
                            viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  current = index;
                                });
                              }
                          )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imgList.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => carouselController.animateToPage(entry.key),
                            child: Container(
                              width: 7.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.black)
                                      .withOpacity(current == entry.key ? 0.9 : 0.4)),
                            ),
                          );
                        }).toList(),
                      ),
                      // Image.asset("assets/images/banner1.png"),
                      SizedBox(height: 20.h,),
                      Text('Category',style: TextStyles.k16Bold(),),
                      SizedBox(height: 10.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () async {
                              Utils(context).startLoading();
                              await Get.find<CategoryController>().getCategoryProduct("electronics");
                              Utils(context).stopLoading();
                              Get.to(() => const CategoryProductScreen(categoryName: 'Electronics'));
                            },
                            child: Column(
                              children: [
                                Image.asset("assets/icons/electronics.png",height: 50.h,),
                                SizedBox(height: 5.h,),
                                Text('Electronics',style: TextStyles.k10Regular(),)
                              ],
                            ),
                          ),
                          SizedBox(width: 10.w,),
                          InkWell(
                            onTap: () async {
                              Utils(context).startLoading();
                              await Get.find<CategoryController>().getCategoryProduct("men's clothing");
                              Utils(context).stopLoading();
                              Get.to(() => const CategoryProductScreen(categoryName: "Men's Cloths"));
                            },
                            child: Column(
                              children: [
                                Image.asset("assets/icons/cloths.png",height: 50.h,),
                                SizedBox(height: 5.h,),
                                Text("Men's Cloths",style: TextStyles.k10Regular(),)
                              ],
                            ),
                          ),
                          SizedBox(width: 10.w,),
                          InkWell(
                            onTap: () async {
                              Utils(context).startLoading();
                              await Get.find<CategoryController>().getCategoryProduct("jewelery");
                              Utils(context).stopLoading();
                              Get.to(() => const CategoryProductScreen(categoryName: 'Jewellery'));
                            },
                            child: Column(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset("assets/icons/jewellery.jpg",height: 50.h,)
                                ),
                                SizedBox(height: 5.h,),
                                Text("Jewellery",style: TextStyles.k10Regular(),)
                              ],
                            ),
                          ),
                          SizedBox(width: 10.w,),
                          InkWell(
                            onTap: () async {
                              Utils(context).startLoading();
                              await Get.find<CategoryController>().getCategoryProduct("women's clothing");
                              Utils(context).stopLoading();
                              Get.to(() => const CategoryProductScreen(categoryName: "Women's cloths"));
                            },
                            child: Column(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset("assets/icons/cloths.png",height: 50.h,)
                                ),
                                SizedBox(height: 5.h,),
                                Text("Women's cloths",style: TextStyles.k10Regular(),)
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      Text('Recent Products', style: TextStyles.k16Bold(),),
                      GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 210.h,
                              crossAxisSpacing: 10.w,
                            mainAxisSpacing: 10.h
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
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
                    ],
                  ),
                ),

              ],
            ),
          ),
        );
      }
    );
  }
}
