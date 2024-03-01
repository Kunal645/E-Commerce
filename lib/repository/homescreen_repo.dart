import 'package:ecom/constant/api_constant.dart';
import 'package:ecom/model/product_model.dart';
import '../networking/networking.dart';

class HomeScreenRepo{

  getProducts() async {
    var data  = await ApiService().get(APIConstant.productUrl);
    List<ProductModel> products = [];
    data.forEach((element){
      products.add(ProductModel.fromJson(element));
    });
    print(products);
    return products;
  }

}