import 'package:ecom/model/product_model.dart';
import 'package:ecom/repository/category_repo.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController{

  CategoryRepo repo = CategoryRepo();
  RxList<ProductModel> products = <ProductModel>[].obs;

  getCategoryProduct(String category) async {
      products.value = await repo.getCategoryProducts(category);
      print(products);
  }
}