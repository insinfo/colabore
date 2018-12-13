import 'package:colabore/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:colabore/data/database_helper.dart';
import 'dart:async';
import 'package:colabore/auth.dart';
import 'package:colabore/services/auth_service.dart';

class AppSettings {

  static final webServiceBaseURL = "https://jubarte.riodasostras.rj.gov.br";
  static final rotaLogin = webServiceBaseURL + "/api/app/auth/login";
  static final rotaTipoColaboracoes = webServiceBaseURL + "/ciente/api/app/servicos";
  static final rotaColaboracoes = webServiceBaseURL + "/ciente/api/app/solicitacao";
  static final rotaCriaColaboracao = webServiceBaseURL + "/ciente/api/app/solicitacao";
  static final rotaCriaUsuario = webServiceBaseURL + "/api/app/user";
  static final userAgent = "appjubarte";
  static Usuario user;
  static String token = "";
  static final mapboxAccessToken = "pk.eyJ1IjoicG1ybyIsImEiOiJjanBiZmFsaXIwZTJhM2tudW41dDQwbmF3In0.4F5dsSSKPpQ0RamUb47CKw";

  static Future logout(BuildContext context) async {
    try {
      var db = new DatabaseHelper();
      await db.deleteUsers();
    }catch(Ex){
      print("erro ao sair");
    }
    //await db.close();
    Navigator.of(context).pushReplacementNamed("/login");
  }

  static Future<Usuario> login(BuildContext context, String _username,String _password) async {
    AuthService authService = new AuthService();
    var user = await authService.doLogin(_username, _password);
    if(user != null) {
      var db = new DatabaseHelper();
      await db.deleteUsers();
      await db.saveUser(user);
      Navigator.of(context).pushReplacementNamed("/home");
    }
    return user;
  }

}
