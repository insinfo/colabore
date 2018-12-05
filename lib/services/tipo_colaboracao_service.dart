import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:colabore/models/tipo_colaboracao.dart';
import 'package:colabore/models/tipo_colaboracao_req.dart';
import 'package:colabore/app_settings.dart';
import 'package:colabore/data/database_helper.dart';
import 'package:colabore/models/usuario.dart';
import 'package:colabore/models/colaboracao_req.dart';
import 'package:colabore/models/colaboracao.dart';

class ColaboracaoService {

  //singleton
  //static final ColaboracaoService _internal = ColaboracaoService.internal();
  //factory ColaboracaoService () => _internal;
  //ColaboracaoService.internal();

  String token = AppSettings.token;
  String message = "";
  Map<String,String> header = {
        "User-Agent": AppSettings.userAgent,
        "Authorization": "Bearer "+AppSettings.token
      }; 

  /// lista todos os serviços / tipo de solicitação
  Future<List<TipoColaboracao>> getTiposColaboracao() async {
    try {
      // var dataToSender = {"userName": username, "password": password};
      var response =
          await http.get(AppSettings.rotaTipoColaboracoes, headers: header);

      if (response.statusCode == 200) {
        message = "Sucesso";
        var tipoColRer = TipoColaboracaoReq.fromJson(json.decode(response.body));
        var data = tipoColRer.data;
        return data;
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

  /// lista todos os serviços / tipo de solicitação
  Future<List<Colaboracao>> getColaboracoes() async {
    try {      
      var url = AppSettings.rotaColaboracoes+"?operador="+ AppSettings.user.idPessoa.toString();
      var response =
          await http.get(url, headers: header);

      if (response.statusCode == 200) {
        message = "Sucesso";
        var tipoColRer = ColaboracaoReq.fromJson(json.decode(response.body));
        var data = tipoColRer.data;
        return data;
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
