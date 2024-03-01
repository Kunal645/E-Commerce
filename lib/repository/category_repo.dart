import 'package:ecom/constant/api_constant.dart';
import 'package:ecom/model/product_model.dart';
import 'package:ecom/networking/networking.dart';

class CategoryRepo{

  ApiService apiService = ApiService();

  getCategoryProducts(categoryName) async {
    List<ProductModel> list = [];
    var data = await apiService.get(APIConstant.categoryUrl + categoryName);
    data.forEach((element){
      list.add(ProductModel.fromJson(element));
    });
    return list;
  }

}