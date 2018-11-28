import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:colabore/models/tipo_colaboracao.dart';
import 'package:colabore/models/tipo_colaboracao_req.dart';
import 'package:colabore/app_settings.dart';
import 'package:colabore/data/database_helper.dart';
import 'package:colabore/models/usuario.dart';

class ColaboracaoService {
  String token = "";
  String message = "";

  ColaboracaoService() {
    var db = new DatabaseHelper();

    db.getFistUser().then((Usuario user) {
      token = user.accessToken;
    }).catchError((Exception error) {
      print(error.toString());
    });
  }

  /// lista todos os serviços / tipo de solicitação
  Future<List<TipoColaboracao>> getAllTipo() async {
    try {
      // var dataToSender = {"userName": username, "password": password};
      var header = {"User-Agent": AppSettings.userAgent};
      var response =
          await http.get(AppSettings.rotaTipoColaboracoes, headers: header);

      if (response.statusCode == 200) {
        message = "Sucesso";
        var tipoColRer =
            TipoColaboracaoReq.fromJson(json.decode(response.body));
        return tipoColRer.data;
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
