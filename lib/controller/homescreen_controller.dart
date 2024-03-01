import 'package:ecom/model/product_model.dart';
import 'package:ecom/repository/homescreen_repo.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HomeScreenController extends GetxController{

  HomeScreenRepo repo = HomeScreenRepo();

  RxList<ProductModel> products = <ProductModel>[].obs;

  Box? chatBox;

  getProduct() async {
    chatBox = await Hive.openBox('productBox');
    var data = chatBox!.get('products');
    if(data == null){
      products.value = await repo.getProducts();
      await chatBox!.put('products', products);
    }
    else{
      products.value = (data as List<dynamic>).cast<ProductModel>();
    }

  }

}