import 'package:ecom/constant/api_constant.dart';
import 'package:ecom/model/cart_model.dart';
import 'package:ecom/networking/networking.dart';

class CartRepo {

  ApiService service = ApiService();
  
  getCart() async{
    var data = await service.get(APIConstant.cartUrl);
    return CartModel.fromJson(data);
  }
  
  updateCart(var body) async {
    await service.put(APIConstant.cartUrl, body);
  }
  
  addToCart(body) async {
    var data = await service.post("https://fakestoreapi.com/carts", body);
    return CartModel.fromJson(data);
  }
  
}