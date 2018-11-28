import 'package:colabore/data/rest_ds.dart';
import 'package:colabore/models/usuario.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:colabore/app_settings.dart';
import 'package:colabore/services/auth_service.dart';

abstract class LoginScreenContract {
  void onLoginSuccess(Usuario user);
  void onLoginError(String errorTxt);
}

class LoginScreenPresenter {
  LoginScreenContract _view;
 // RestDatasource api = new RestDatasource();
  AuthService authService = new AuthService();

  LoginScreenPresenter(this._view);

  doLogin(String username, String password) async {

    var user = await authService.doLogin(username, password);
    if(user != null){
      _view.onLoginSuccess(user);
    }else{
      _view.onLoginError(authService.message);
    }

  }

}