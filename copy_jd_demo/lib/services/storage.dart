import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // 添加
  static Future<void> setString(key, value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }

  // 获取
  static Future<String> getString(key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return (sp.getString(key))!;
  }

  // 删除
  static Future<void> remove(key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(key);
  }

  // 清空缓存
  static Future<void> clear() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }
}
