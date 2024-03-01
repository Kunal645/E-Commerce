import 'dart:convert';

import 'package:ecom/repository/cart_repo.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../model/cart_model.dart';
import '../model/product_model.dart';
import 'homescreen_controller.dart';

class CartController extends GetxController{

  CartRepo repo = CartRepo();
  Rx<CartModel> cart = CartModel().obs;
  RxList<ProductModel> cartList = <ProductModel>[].obs;

  Box? cartBox;
  getCart() async {
    List<ProductModel> list = [];
    cartBox = await Hive.openBox("cartBox");
    var cartData = cartBox!.get("cart");
    var cartProductData = cartBox!.get("cartProducts");
    if(cartData == null){
      cart.value = await repo.getCart();
      await cartBox!.put("cart", cart.value);
    }
    else{
      cart.value = cartData;
    }
    if(cartProductData == null || cartProductData.isEmpty){
      for(var product in Get.find<HomeScreenController>().products){
        if(cart.value.products!.any((element) => product.id == element.productId)){
          list.add(product);
        }
      }
      cartList.value = list;
      await cartBox!.put("cartProducts", list);
    }
    else{
      cartList.value = (cartProductData as List<dynamic>).cast<ProductModel>();
    }
    manageAddsOn();
  }

  countItemValue(String price, String quantity){
    var total = double.parse(price) * int.parse(quantity);
    return total;
  }

  incrementItem(index, id) async {
    cart.value.products![index] = CartProducts(quantity: (cart.value.products![index].quantity! + 1),productId: id);
    cart.update((val) { });
    await cartBox!.put("cart", cart.value);
    await updateCart(cart.value);
    await totalCount();
  }

  decrementItem(index, int? id) async {
    if(cart.value.products![index].quantity! > 1){
      cart.value.products![index] = CartProducts(quantity: (cart.value.products![index].quantity! - 1),productId: id);
      cart.update((val) { });
      await cartBox!.put("cart", cart.value);
      await updateCart(cart.value);
      totalCount();
    }
  }

  updateCart(CartModel cartModel) async {
    var body = json.encode(cartModel);
    await repo.updateCart(body);
  }

  addToCart(CartModel cartModel, ProductModel product) async{
    var existingProductIndex = cart.value.products!.indexWhere(
          (element) => element.productId == product.id,
    );
    if (existingProductIndex != -1) {
      cart.value.products![existingProductIndex].quantity =
          (cart.value.products![existingProductIndex].quantity ?? 0) + 1;
    } else {
      cartList.add(product);
      cart.value.products!.add(cartModel.products![0]);
      await cartBox!.put("cartProducts", cartList.value);
    }
    cart.update((val) {},);
    await cartBox!.put("cart", cart.value);
    totalCount();
    manageAddsOn();
  }

  RxDouble total = 0.0.obs;
  RxDouble grandTotal = 0.0.obs;
  totalCount(){
    var countTotal = 0.0;
    for (var element in cartList) {
      for (var prod in cart.value.products!) {
        if(element.id == prod.productId){
          countTotal = countTotal + countItemValue(element.price.toString(),prod.quantity.toString());
        }
      }
    }
    total.value = countTotal;
    grandTotal.value = total.value + 50 - 100;
    total.update((val) { });
    grandTotal.update((val) { });
  print(total);
  return total;
  }

  removeItem(index, int? id) async {
    cart.value.products![index] = CartProducts(quantity: (0),productId: id);
    cartList.removeAt(index);
    cart.value.products!.removeAt(index);
    totalCount();
    cart.update((val) { });
    await cartBox!.put("cartProducts", cartList.value);
    await cartBox!.put("cart", cart.value);
    manageAddsOn();
  }

  List<ProductModel> addOnProducts = <ProductModel>[].obs;

  manageAddsOn(){
    Set<String>? list;
    addOnProducts.clear();
    Set<int> cartProductIds = cartList.map((item) => item.id!).toSet();
    if(cartList.isNotEmpty){
      list = cartList.map((element) => element.category.toString()).toSet();
    }
    for (var category in list!) {
      List<ProductModel> categoryAddOns = Get.find<HomeScreenController>().products.where((addOn) => addOn.category == category).toList();
      if (categoryAddOns.length > 3) {
        categoryAddOns.shuffle();
        categoryAddOns = categoryAddOns.sublist(0, 3);
      }
      addOnProducts.addAll(categoryAddOns);
    }
    addOnProducts.removeWhere((addOn) => cartProductIds.contains(addOn.id));
    print(addOnProducts);
  }

}