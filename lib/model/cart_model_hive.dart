import 'package:ecom/model/cart_model.dart';
import 'package:hive/hive.dart';

class CartModelAdapter extends TypeAdapter<CartModel>{
  @override
  CartModel read(BinaryReader reader) {
    final Map<dynamic, dynamic> fields = reader.readMap();
    return CartModel.fromJson(fields);
  }

  @override
  final int typeId = 3;

  @override
  void write(BinaryWriter writer, CartModel obj) {
    writer.writeMap(obj.toJson());
  }

}

class CartProductsAdapter extends TypeAdapter<CartProducts>{
  @override
  CartProducts read(BinaryReader reader) {
    final Map<dynamic, dynamic> fields = reader.readMap();
    return CartProducts.fromJson(fields);
  }

  @override
  final int typeId = 4;

  @override
  void write(BinaryWriter writer, CartProducts obj) {
    writer.writeMap(obj.toJson());
  }

}