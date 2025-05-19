import 'dart:convert';
import 'package:cashback_info/internal/api/api.swagger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _userTokenKey = 'userToken';

  Future<void> saveUserToken(UserToken userToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(userToken.toJson());
    await prefs.setString(_userTokenKey, jsonString);
  }

  Future<UserToken?> getUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_userTokenKey);

    if (jsonString != null) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return UserToken.fromJson(jsonMap);
    }
    return null;
  }

  Future<void> clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userTokenKey);
  }
}
