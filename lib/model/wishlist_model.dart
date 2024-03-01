import 'package:ecom/model/product_model.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 5)
class WishListModel{

  @HiveField(0)
  int? id;

  @HiveField(0)
  List<ProductModel>? products;

  WishListModel({this.id,this.products});

  WishListModel.fromJson(Map<dynamic,dynamic> json){
    id = json["id"];
    if(json["products"] != null){
      products = (json["products"] as List<dynamic>).cast<ProductModel>();
    }
    else{
      products = [];
    }
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['products'] = products;
    return data;
  }

}