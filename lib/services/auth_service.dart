import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:colabore/models/usuario.dart';
import 'package:colabore/app_settings.dart';
import 'package:colabore/app_strings.dart';

class AuthService {
  String message = "";

  Future<Usuario> doLogin(String username, String password) async {
    try {
      var loginData = {"userName": username, "password": password};
      var header = {"User-Agent": AppSettings.userAgent};

      var response = await http.post(AppSettings.rotaLogin,
          headers: header, body: loginData);

      if (response.statusCode == 200) {
        message = AppStrings.sucesso;
        var user = Usuario.fromJson(json.decode(response.body));
        AppSettings.user = user;
        AppSettings.token = user.accessToken;
        return user;
      } else if (response.statusCode == 401) {
        message = AppStrings.credencialInvalida;
        return null;
      } else if (response.statusCode == 400) {
        message = AppStrings.erroComunicarServidor;
        return null;
      } else {
        message = AppStrings.erroComunicarServidor;
        return null;
      }
    } catch (e) {
      message = AppStrings.erroComunicarServidor;
      print("doLogin "+e.toString());
      return null;
    }
  }
}
