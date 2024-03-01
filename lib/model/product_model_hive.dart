import 'package:ecom/model/product_model.dart';
import 'package:hive/hive.dart';

class ProductModelAdapter extends TypeAdapter<ProductModel>{
  @override
  ProductModel read(BinaryReader reader) {
    final Map<dynamic, dynamic> fields = reader.readMap();
    return ProductModel.fromJson(fields);
  }

  @override
  final int typeId = 1;

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer.writeMap(obj.toJson());
  }

}

class RatingModelAdapter extends TypeAdapter<Rating>{
  @override
  Rating read(BinaryReader reader) {
    final Map<dynamic, dynamic> fields = reader.readMap();
    return Rating.fromJson(fields);
  }

  @override
  final int typeId = 2;

  @override
  void write(BinaryWriter writer, Rating obj) {
    writer.writeMap(obj.toJson());
  }

}