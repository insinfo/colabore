import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:colabore/models/usuario.dart';
import 'package:colabore/app_settings.dart';

class AuthService {
  String message = "";

  Future<Usuario> doLogin(String username, String password) async {
    try {
      var loginData = {"userName": username, "password": password};
      var header = {"User-Agent": AppSettings.userAgent};
      var response = await http.post(AppSettings.rotaLogin,
          headers: header, body: loginData);

      if (response.statusCode == 200) {
        message = "Sucesso";
        return Usuario.fromJson(json.decode(response.body));
      } else if (response.statusCode == 401) {
        message = "Credencial Inválida";
        return null;
      } else if (response.statusCode == 400) {
        message = "Erro no servidor";
        return null;
      } else {
        message = "Erro no servidor";
        return null;
      }
    } catch (e) {
      message = "Erro de internet";
      print(e.toString());
      return null;
    }
  }
}
