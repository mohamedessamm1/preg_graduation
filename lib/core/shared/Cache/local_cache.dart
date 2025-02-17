import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static initcache() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> savedata(
      {required key, required dynamic value, type}) async {
    if (value is String) return sharedPreferences!.setString(key, value);
    if (type == 'number') sharedPreferences!.setInt(key, value);
    if (value is bool) return sharedPreferences!.setBool(key, value);
    if (value is double) return sharedPreferences!.setDouble(key, value);
    return await sharedPreferences!.setInt(key, value);
  }




////////////////////////////////////////////////////////////////////////////

 static List<Map<String, dynamic>> getActiveDays()  {
    String? jsonString = sharedPreferences!.getString('homeList');

    if (jsonString == null) {
      return []; // إرجاع قائمة فارغة إذا لم تكن هناك بيانات محفوظة
    }

    List<dynamic> jsonList = jsonDecode(jsonString);
    List<Map<String, dynamic>> allDays = jsonList.cast<Map<String, dynamic>>();

    // تصفية العناصر التي حالتها true فقط
    List<Map<String, dynamic>> activeDays = allDays.where((day) => day['status'] == true).toList();
print(activeDays);
    return activeDays;
  }



  /////////////////////////////////////////////////////


  static Future<void> saveHomeList() async {
    String jsonString = jsonEncode(homeList);
    await sharedPreferences!.setString('homeList', jsonString);
  }

  static getdata({
    required key,
  }) {
    return sharedPreferences?.get(key);
  }

  static removedata({required key}) async {
    return await sharedPreferences!.remove(key).then((value) {
      print('removedata');
    });
  }
}
