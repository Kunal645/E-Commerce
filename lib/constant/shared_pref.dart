import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{

  late final SharedPreferences pref;
  getPref() async {
    pref = await SharedPreferences.getInstance();
    return pref;
  }

}