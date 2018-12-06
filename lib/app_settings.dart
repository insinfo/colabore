import 'package:colabore/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:colabore/data/database_helper.dart';
import 'dart:async';

class AppSettings {

  static final webServiceBaseURL = "https://jubarte.riodasostras.rj.gov.br";
  static final rotaLogin = webServiceBaseURL + "/api/app/auth/login";
  static final rotaTipoColaboracoes = webServiceBaseURL + "/ciente/api/app/servicos";
  static final rotaColaboracoes = webServiceBaseURL + "/ciente/api/app/solicitacao";
  static final rotaCriaColaboracao = webServiceBaseURL + "/ciente/api/app/solicitacao";
  static final userAgent = "appjubarte";
  static Usuario user;
  static String token = "";

  static Future logout(BuildContext context) async {
    var db = new DatabaseHelper();
    await db.deleteUsers();
    //await db.close();
    Navigator.of(context).pushReplacementNamed("/login");
  }

}
