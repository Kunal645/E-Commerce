import 'package:ecom/model/wishlist_model.dart';
import 'package:hive/hive.dart';

class WishlistModelAdapter extends TypeAdapter<WishListModel>{
  @override
  WishListModel read(BinaryReader reader) {
    final Map<dynamic, dynamic> fields = reader.readMap();
    return WishListModel.fromJson(fields);
  }

  @override
  final int typeId = 5;

  @override
  void write(BinaryWriter writer, WishListModel obj) {
    writer.writeMap(obj.toJson());
  }

}