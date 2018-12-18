import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:colabore/models/usuario.dart';
import 'package:colabore/app_settings.dart';
import 'package:colabore/app_strings.dart';

class AuthService {
  String message = "";
  Map<String,String> header = {
    "User-Agent": AppSettings.userAgent,
    "Content-Type": "application/json"
  };

  Future<Usuario> doLogin(String username, String password) async {
    try {
      var dataToSend = {"userName": username, "password": password};

      var response = await http.post(AppSettings.rotaLogin,
          headers: header, body: jsonEncode(dataToSend));

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
  ///envia pro email do usuario um codigo para ele digitar no App
  ///retorna um codigo
  Future<String> requisitarNovaSenha(String email) async {
    try {

      var dataToSend = {"email": email};

      var response = await http.post(AppSettings.rotaCodigoRecuperaAcesso,
          headers: header, body: jsonEncode(dataToSend));

      print(dataToSend);
      print(response.body);  print(response.statusCode);

      if (response.statusCode == 200) {
        message = AppStrings.sucesso;

        var resp = json.decode(response.body);
        return resp["code"].toString();

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
      print("requisitarNovaSenha "+e.toString());
      return null;
    }
  }



}
