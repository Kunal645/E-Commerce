import 'package:ecom/constant/color_constant.dart';
import 'package:ecom/model/product_model.dart';
import 'package:ecom/model/wishlist_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class WishlistController extends GetxController{

  Box? wishListBox;

  Rx<WishListModel> wishlist = WishListModel().obs;

  getWishlist() async {
    wishListBox = await Hive.openBox("wishlistBox");
    var cartData = wishListBox!.get("wishlistProduct");
    if(cartData != null){
      wishlist.value = cartData;
    }
  }

  addWishlist(ProductModel productModel,context) async {
    List<ProductModel> product = wishlist.value.products ?? [];
    product.add(productModel);
    wishlist.value = WishListModel(id: (wishlist.value.products != null ? wishlist.value.products!.length + 1 : 1),products: product);
    await wishListBox!.put("wishlistProduct", wishlist.value);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: ColorConstant.kPrimaryColor,
      elevation: 2,
      content: const Text("Successfully added item in favourite"),
    ));
  }

  removeWishList(ProductModel product,context) async {
    var existingProductIndex = wishlist.value.products!.indexWhere(
          (element) => element.id == product.id,
    );
    wishlist.value.products!.removeAt(existingProductIndex);
    wishlist.update((val) { });
    await wishListBox!.put("wishlistProduct", wishlist.value);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: ColorConstant.kPrimaryColor,
      elevation: 2,
      content: const Text("Successfully remove item in favourite"),
    ));
  }

}