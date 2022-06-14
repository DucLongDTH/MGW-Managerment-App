import 'package:app_demo_flutter/config/core/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferencesImpl extends AppSharedPreferences<SharedPreferences> {
  @override
  Future<bool> setString(String key, String value) {
    return SharedPreferences.getInstance()
        .then((store) => store.setString(key, value));
  }

  @override
  Future<String?> getString(String key) {
    return SharedPreferences.getInstance()
        .then((store) => store.getString(key));
  }

  @override
  Future<bool> setDouble(String key, double value) {
    return SharedPreferences.getInstance()
        .then((store) => store.setDouble(key, value));
  }

  @override
  Future<double?> getDouble(String key) {
    return SharedPreferences.getInstance()
        .then((store) => store.getDouble(key));
  }

  @override
  Future<bool> setBool(String key, bool value) {
    return SharedPreferences.getInstance()
        .then((store) => store.setBool(key, value));
  }

  @override
  Future<bool?> getBool(String key) {
    return SharedPreferences.getInstance().then((store) => store.getBool(key));
  }

  @override
  Future<bool> setInt(String key, int value) {
    return SharedPreferences.getInstance()
        .then((store) => store.setInt(key, value));
  }

  @override
  Future<int?> getInt(String key) {
    return SharedPreferences.getInstance().then((store) => store.getInt(key));
  }

  @override
  Future<bool> setStringList(String key, List<String> value) {
    return SharedPreferences.getInstance()
        .then((store) => store.setStringList(key, value));
  }

  @override
  Future<List<String>?> getStringList(String key) {
    return SharedPreferences.getInstance()
        .then((store) => store.getStringList(key));
  }

  @override
  Future<bool> remove(String key) {
    return SharedPreferences.getInstance().then((store) => store.remove(key));
  }

  @override
  Future<bool> clear() {
    return SharedPreferences.getInstance().then((store) => store.clear());
  }

  @override
  Future<bool> containsKey(String key) {
    return SharedPreferences.getInstance()
        .then((store) => store.containsKey(key));
  }

  @override
  Future<void> reload() {
    return SharedPreferences.getInstance().then((store) => store.reload());
  }

  @override
  Future<SharedPreferences> get getSharedPreferences {
    return SharedPreferences.getInstance();
  }
}