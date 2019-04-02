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
import 'package:colabore/models/colaborar.dart';
import 'package:colabore/models/cadastro_user_req.dart';
import 'package:colabore/app_strings.dart';

import 'package:flutter/services.dart' show rootBundle;

class ColaboracaoService {

  //singleton
  //static final ColaboracaoService _internal = ColaboracaoService.internal();
  //factory ColaboracaoService () => _internal;
  //ColaboracaoService.internal();

  String token = AppSettings.token;
  String message = "";
  int statusCode;
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
        message = AppStrings.sucesso;
        var tipoColaboracaoResponse = TipoColaboracaoReq.fromJson(json.decode(response.body));
        //print("getTiposColaboracao "+response.body);
        return tipoColaboracaoResponse.listTipoColaboracao;

      } else if (response.statusCode == 401) {
        //print("getTiposColaboracao "+response.body);
        message = AppStrings.credencialInvalida;
        return null;
      } else if (response.statusCode == 400) {
        //print("getTiposColaboracao "+response.body);
        message = AppStrings.erroComunicarServidor;
        return null;
      } else {
        //print("getTiposColaboracao "+response.body);
        message = AppStrings.erroComunicarServidor;
        return null;
      }
    } catch (e) {
      message = AppStrings.erroComunicarServidor;
      print("getTiposColaboracao "+e.toString());
      return null;
    }
  }

  /// lista todos os serviços / tipo de solicitação
  Future<List<Colaboracao>> getColaboracoes({offset=0,limit=50,page=0}) async {
    try {
      var limite = limit;
      var inicio = offset;
      String url = "${AppSettings.rotaColaboracoes}?operador=${AppSettings.user.idPessoa.toString()}&limit=${limite.toString()}&offset=${inicio.toString()}";
      var response =
          await http.get(url, headers: header);


      if (response.statusCode == 200) {
        message = AppStrings.sucesso;

        var colaboracaoResponse = ColaboracaoReq.fromJson(json.decode(response.body));
        return colaboracaoResponse.listColaboracao;

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
      print("getColaboracoes "+e.toString());
      return null;
    }
  }

  /// cria uma nova colaboração
  Future<bool> postNewColaboracao(Colaborar newColaboracao) async {
    try {//Map<String,dynamic>

      var body = jsonEncode(newColaboracao.toJson());
      /*var response =
      await http.post(AppSettings.rotaCriaColaboracao, headers: header,body: body);*/

      var request = new http.MultipartRequest("POST", Uri.parse(AppSettings.rotaCriaColaboracao));
      request.headers["Authorization"] = "Bearer "+AppSettings.token;
      request.headers["User-Agent"] = AppSettings.userAgent;
      request.fields['data'] = body;
      /*request.files.add(http.MultipartFile.fromPath(
        'package',
        'build/package.tar.gz',
        contentType: new MediaType('application', 'x-tar'),
      ));*/
      if(newColaboracao.imagemPath != null) {
        var file = await http.MultipartFile.fromPath(
            'file', newColaboracao.imagemPath);
        request.files.add(file);
      }

      var response = await request.send();
      var responseData = await response.stream.bytesToString(utf8);
      print(responseData);
      print(response.statusCode);
      // listen for response
      /*response.stream.transform(utf8.decoder).listen((value) {

      });*/

      if (response.statusCode == 200) {
        var data = json.decode(responseData);
        message = "Foi criada uma nova solicitação com o número "+data["numeroSolicitacao"];

        return true;
      } else if (response.statusCode == 401) {
        message = AppStrings.credencialInvalida;
        return false;
      } else if (response.statusCode == 400) {
        message = AppStrings.erroComunicarServidor;
        return false;
      } else if (response.statusCode == 406) {
        message = "Você preencheu um campo com valo incorreto";
        return false;
      } else if (response.statusCode == 409) {
        message = "Já exite uma colaboração para este serviço proximo a este local.";
        return false;
      }else {
        message = AppStrings.erroComunicarServidor;
        return false;
      }
    } catch (e) {
      message = AppStrings.erroComunicarServidor;
      print("postNewColaboracao "+e.toString());
      return false;
    }
    return true;
  }

  /// cria um novo usuario
  Future<Map<String,dynamic>> postNewUser(CadastroUserReq newUser) async {
    try {

      var dataToSend = jsonEncode(newUser.toJson());
      print(dataToSend);

      var h = {"User-Agent": AppSettings.userAgent, "Content-Type": "application/json"};

      var response =
      await http.post(AppSettings.rotaCriaUsuario, headers: h,body: dataToSend);

      statusCode = response.statusCode;

      print(response.body);
      print(statusCode);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        message = AppStrings.sucesso;
        return data["data"];
      } else if (response.statusCode == 401) {
        message = AppStrings.credencialInvalida;
        return null;
      } else if (response.statusCode == 409) {
        message = AppStrings.usuarioJaExiste;
        return null;
      } else if (response.statusCode == 406) {
        message = "Você preencheu um campo do formulário errado, por favor verifique os dados e tente novamente";
        return null;
      }else if (response.statusCode == 400) {
        message = AppStrings.erroComunicarServidor;
        return null;
      } else {
        message = AppStrings.erroComunicarServidor;
        return null;
      }
    } catch (e) {
      message = AppStrings.erroComunicarServidor;
      print("postNewUser "+e.toString());
      return null;
    }
    return null;
  }

  Future<List<String>> getBairros() async {
    List<String> _bairros = <String>[
      "Alphaville",
      "Âncora",
      "Atlântica",
      "Balneário das Garças",
      "Balneário Remanso",
      "Boca da Barra",
      "Bosque Beira Rio",
      "Bosque da Areia",
      "Bosque da Praia",
      "Cantagalo",
      "Cantinho do Mar",
      "Casa Grande",
      "Centro",
      "Chácara Mariléa",
      "Cidade Beira Mar",
      "Cidade Praiana",
      "Colinas",
      "Condomínio Porto Seguro",
      "Costazul",
      "Enseada das Gaivotas",
      "Extensão do Bosque",
      "Extensão Novo Rio das Ostras",
      "Extensão Serramar",
      "Fazenda Palmeiras",
      "Floresta das Gaivotas",
      "Gelson Apicelo",
      "Jardim Bela Vista",
      "Jardim Campomar",
      "Jardim Mariléa",
      "Jardim Miramar",
      "Jardim Patrícia",
      "Liberdade",
      "Mar do Norte",
      "Mar Y Lago",
      "Maria Turri",
      "Nova Aliança",
      "Nova Cidade",
      "Nova Esperança",
      "Novo Rio das Ostras",
      "Operário",
      "Ouro Verde",
      "Palmital",
      "Parque São Jorge",
      "Parque Zabulão",
      "Peroba",
      "Praia Mar",
      "Recanto",
      "Recreio",
      "Reduto da Paz",
      "Residencial Camping do Bosque",
      "Residencial Rio das Ostras",
      "Rocha Leão",
      "São Cristóvão",
      "Serramar",
      "Sobradinho Cerveja",
      "Terra Firme",
      "Terras do Contorno",
      "Verdes Mares",
      "Vila Real",
      "Village Rio das Ostras",
      "Village Sol e Mar",
      "Viverde I",
      "Zona Zen"
    ];
    return _bairros;
  }

  Future<String> getTermos() async {
    try {
      return await rootBundle.loadString("assets/termos.txt");
    }catch(e){
      print("getTermos "+e.toString());
      return "erro ao carregar termos";
    }
  }
}
