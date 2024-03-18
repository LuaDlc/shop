import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/store.dart';
import 'package:shop/exceptions/auth_exceptions.dart';
import 'package:shop/utils/constants.dart';

class Auth with ChangeNotifier {
  //aqui abaixo tudo que é requisitado para o token
  String? _token;
  String? _email;
  String? _userId;
  DateTime? _expiryDate;
  Timer? _logoutTimer;

  bool get isAuth {
    final isValid = _expiryDate?.isAfter(DateTime.now()) ??
        false; //para saber se token esta valido ou expirou, se esta no futuro retorna falso
    return _token != null &&
        isValid; //se token foi setado(nao é null) e isValid é true
    //pra saber se o usuario esta autenticado
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get userId {
    return isAuth ? _userId : null;
  }

  Future<void> authenticate(
      String email, String password, String urlFragment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=${Constants.webApiKey}';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthExceptions(body['error']['message']);
    } else {
      //se nao tiver erro, salvo essas informacoes, pelo body e as chaves do firebase
      _token = body['idToken'];
      _email = body['email'];
      _userId = body['localId'];

      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(body['expiresIn']),

          //pega a data atual e adiciona o expiresIns(segundos) e assim vai saber quando o token fica invalido
        ),
      );
      Store.saveMap('userData', {
        //sa;vando os dados com o store
        'token': _token,
        'email': _email,
        'userId': _userId,
        'expiryDate': _expiryDate!.toIso8601String(),
      });

      _autoLogout();
      notifyListeners();
    }
  }

  Future<void> signup(String email, String password) async {
    return authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return authenticate(email, password, 'signInWithPassword');
  }

  //recuperando os dados para fazer o login automatico

  Future<void> tryAutoLogin() async {
    //verificacoes pra saber se vai tentar fazer o autologin
    //se estive autenticado
    if (isAuth) return;

    final userData = await Store.getMap('userData');
    if (userData.isEmpty) return; // se userdata vazio sai;

    final expiryDate = DateTime.parse(userData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) return;

    //entao restaura os dados
    _token = userData['token'];
    _email = userData['email'];
    _expiryDate = expiryDate;

    _autoLogout();
    notifyListeners();
  }

  void logout() {
    _token = null;
    _email = null;
    _userId = null;
    _expiryDate = null;
    _clearLogoutTimer();
    Store.remove('userData').then((_) {
      notifyListeners();
    });
  }

  void _clearLogoutTimer() {
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }

  void _autoLogout() {
    _clearLogoutTimer();
    final timeLogout = _expiryDate
        ?.difference(DateTime.now())
        .inSeconds; //se expirydate nao estiver nulo chama a funcao differencie com a data atual
    print(timeLogout);
    _logoutTimer = Timer(Duration(seconds: timeLogout ?? 0), logout);
  }
}
