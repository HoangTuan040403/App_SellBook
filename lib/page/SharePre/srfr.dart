import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String _usernameKey = 'username'; // đang để là pass
  static final String _emailKey = 'email';
  static final String _idKey = '_id';

  // Lưu thông tin người dùng vào SharedPreferences
  static Future<void> saveUserCredentials(String id, String username, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
    await prefs.setString(_emailKey, email);
    await prefs.setString(_idKey, id);
  }

  // Lấy thông tin người dùng từ SharedPreferences
  // đang để là lấy mật khẩu
  static Future<String?> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  static Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }

  static Future<String?> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_idKey);
  }

  // Kiểm tra sự tồn tại của thông tin người dùng
  static Future<bool> hasUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_usernameKey) && prefs.containsKey(_emailKey) && prefs.containsKey(_idKey);
  }

  // Xóa thông tin người dùng khỏi SharedPreferences
  static Future<void> clearUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usernameKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_idKey);
  }
}
