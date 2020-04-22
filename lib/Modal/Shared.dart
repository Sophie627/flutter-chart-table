import 'package:shared_preferences/shared_preferences.dart';
class User{
  int uid;
  User({this.uid});
}



class Shared {

  save(int uid)async{
    print("UID ${uid}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('uid', uid);
    print(await prefs.get('uid'));
  }

  Future getSave()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int uid = await prefs.get('uid');
    return uid;
  }

  Future clear()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    return true;
  }
}