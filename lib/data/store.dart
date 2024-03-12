import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Store {
  //encapsula qualquer chamada dentro do shared preferences
  //usando classe pq fica mais facil mudar o mecanismo como o hive
  static Future<bool> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<bool> saveMap(String key, Map<String, dynamic> value) async {
    //posso chamar o saveString dentro do map
    return saveString(key, jsonEncode(value)); //transforma o value em json
  }

  //metodo que vai ler uma string
  static Future<String> getString(String key, [defaultValue = '']) async {
    final prefs = await SharedPreferences
        .getInstance(); //salvei a instancia em preferencia
    return prefs.getString(key) ??
        defaultValue; //defaul pra nunca rtornar string opcional
  }

  static Future<Map<String, dynamic>> getMap(String key) async {
    try {
      return jsonDecode(await getString(key));
    } catch (e) {
      return {};
    }
  }

  static Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
