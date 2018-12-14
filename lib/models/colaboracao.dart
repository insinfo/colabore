import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:colabore/models/anexo.dart';
import 'package:colabore/app_settings.dart';
class Colaboracao {
  int id;
  String latitude;
  String longitude;
  String bairro;
  String rua;
  String numero;
  int ano;
  String solicitacao_numero;
  String descricao;
  String observacao;
  String dataAbertura;
  String dataFechamento;
  int atendimentoIni;
  int totalAtendimentos;
  int minStatus;
  String servico_nome;
  String servico_icone;
  String servico_cor;
  Anexo anexo;

  String get codigo {
    return this.ano.toString() + this.solicitacao_numero.toString();
  }

  double get getLatitude {
    return double.parse(latitude);
  }

  double get getLongitude {
    return double.parse(longitude);
  }

  String get statusFinal {
    return listStatus[this.minStatus];
  }

  String get imageUrl{

    if(anexo != null){
      if(anexo.url != null){
        return AppSettings.webServiceBaseURL + anexo.url;
      }
    }
    return null;
  }

  String get abertoEm {
    if (dataAbertura != null) {
      var parsedDate = DateTime.parse(dataAbertura);
      var formatter = new DateFormat('dd/MM/yyyy');
      return formatter.format(parsedDate);
    }
    return "";
  }

  String get fechadoEm {
    if (dataFechamento != null) {
      var parsedDate = DateTime.parse(dataFechamento);
      var formatter = new DateFormat('dd/MM/yyyy');
      return formatter.format(parsedDate);
    }
    return "-----";
  }

  MaterialColor get statusFinalColor {
    return listStatusColor[this.minStatus];
  }

  final listStatus = [
    "Aberto",
    "Em andamento",
    "Pendente",
    "Concluido",
    "Cancelado",
    "Duplicado",
    "Sem solução"
  ];

  final listStatusColor = [
    Colors.blue, //"Aberto",
    Colors.amber, // "Em andamento",
    Colors.purpleAccent, //"Pendente",
    Colors.green, //"Concluido",
    Colors.red, //"Cancelado",
    Colors.deepOrange, //"Duplicado"
    Colors.white //"Sem solução"
  ];

  Colaboracao.fromJson(Map<String, dynamic> json) {
    try {
      if (json != null) {
        id = json['id'];
        latitude = json['latitude'];
        longitude = json['longitude'];
        bairro = json['bairro'];
        rua = json['rua'];
        numero = json['numero'];
        ano = json['ano'];
        solicitacao_numero = json['solicitacao_numero'];
        descricao = json['descricao'];
        observacao = json['observacao'];
        dataAbertura = json['dataAbertura'];
        dataFechamento = json['dataFechamento'];
        atendimentoIni = json['atendimentoIni'];
        totalAtendimentos = json['totalAtendimentos'];
        minStatus = json['minStatus'];
        servico_nome = json['servico_nome'];
        servico_icone = json['servico_icone'];
        servico_cor = json['servico_cor'];

        if (json.containsKey('anexo')) {
          anexo = Anexo.fromJson(json['anexo']);
        }

      }
    } catch (e) {}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['id'] = this.id;
    json['latitude'] = this.latitude;
    json['longitude'] = this.longitude;
    json['bairro'] = this.bairro;
    json['rua'] = this.rua;
    json['numero'] = this.numero;
    json['ano'] = this.ano;
    json['solicitacao_numero'] = this.solicitacao_numero;
    json['descricao'] = this.descricao;
    json['observacao'] = this.observacao;
    json['dataAbertura'] = this.dataAbertura;
    json['dataFechamento'] = this.dataFechamento;
    json['atendimentoIni'] = this.atendimentoIni;
    json['totalAtendimentos'] = this.totalAtendimentos;
    json['minStatus'] = this.minStatus;
    json['servico_nome'] = this.servico_nome;
    json['servico_icone'] = this.servico_icone;
    json['servico_cor'] = this.servico_cor;
    json['anexo'] = this.anexo.toJson();
    return json;
  }
}
