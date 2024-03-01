import 'package:ecom/constant/api_constant.dart';
import 'package:ecom/model/user_model.dart';
import '../networking/networking.dart';

class UserRepo{

  getUserData() async {
    var data = await ApiService().get(APIConstant.userUrl);
    return UserModel.fromJson(data);
  }

}