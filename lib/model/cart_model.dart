
import 'package:hive/hive.dart';

@HiveType(typeId: 3)
class CartModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? userId;
  @HiveField(2)
  String? date;
  @HiveField(3)
  List<CartProducts>? products;
  @HiveField(4)
  int? iV;

  CartModel({this.id, this.userId, this.date, this.products, this.iV});

  CartModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    date = json['date'];
    if (json['products'] != null) {
      products = <CartProducts>[];
      json['products'].forEach((v) {
        products!.add(CartProducts.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['date'] = date;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['__v'] = iV;
    return data;
  }
}

@HiveType(typeId: 4)
class CartProducts {
  @HiveField(0)
  int? productId;
  @HiveField(1)
  int? quantity;

  CartProducts({this.productId, this.quantity});

  CartProducts.fromJson(Map<dynamic, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['quantity'] = quantity;
    return data;
  }
}
