import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:colabore/models/anexo.dart';
import 'package:colabore/app_settings.dart';
class Colaboracao {
  int _id;
  String _latitude;
  String _longitude;
  String _bairro;
  String _rua;
  String _numero;
  int _ano;
  String _solicitacaoNumero;
  String _descricao;
  String _observacao;
  String _dataAbertura;
  String _dataFechamento;
  int _atendimentoIni;
  int _totalAtendimentos;
  int _minStatus;
  String _servicoNome;
  String _servicoIcone;
  String _servicoCor;
  Anexo _anexo;

  String get getServicoIcone {
    try {
      if(this._servicoIcone == null){
        return " - ";
      }
      return this._servicoIcone;
    }catch(e){
      return " - ";
    }
  }

  String get getNumero {
    try {
      if(this._numero == null){
        return " - ";
      }
      return this._numero;
    }catch(e){
      return " - ";
    }
  }

  String get getDescricao {
    try {
      if(this._descricao == null){
        return " - ";
      }
      return this._descricao;
    }catch(e){
      return " - ";
    }
  }

  String get getRua {
    try {
      if(this._rua == null){
        return " - ";
      }
      return this._rua;
    }catch(e){
      return " - ";
    }
  }

  String get getBairro {
    try {
      if(this._bairro == null){
        return " - ";
      }
      return this._bairro;
    }catch(e){
      return " - ";
    }
  }

  String get getNumeroSolicitacao {
    try {
      if(this._ano == null){
        return " - ";
      }
      return this._ano.toString() + this._solicitacaoNumero.toString();
    }catch(e){
      return " - ";
    }

  }

  double get getLatitude {
    if(_latitude == null){
      return -22.5272718;
    }
    return double.parse(_latitude);
  }

  double get getLongitude {
    if(_longitude == null){
      return -41.95030867;
    }
    return double.parse(_longitude);
  }

  String get getStatusAsString {
    try {
      return listStatus[this._minStatus];
    }catch(e){
      return " - ";
    }
  }

  String get getImageURL{

    if(_anexo != null){
      if(_anexo.url != null){
        return AppSettings.webServiceBaseURL + _anexo.url;
      }
    }
    return null;
  }

  String get getDataAbertura {
    if (_dataAbertura != null) {
      var parsedDate = DateTime.parse(_dataAbertura);
      var formatter = new DateFormat('dd/MM/yyyy');
      return formatter.format(parsedDate);
    }
    return "";
  }

  String get getNomeServico {
    if (_servicoNome != null) {
      return _servicoNome;
    }
    return " - ";
  }

  String get getDataFechamento {
    try {
    if (_dataFechamento != null) {
      var parsedDate = DateTime.parse(_dataFechamento);
      var formatter = new DateFormat('dd/MM/yyyy');
      return formatter.format(parsedDate);
    }
    return "-----";
    }catch(e){
      return "-----";
    }
  }

  MaterialColor get getStatusColor {
    try {
      return listStatusColor[this._minStatus];
    }catch(e){
      return listStatusColor[0];
    }

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
        _id = json.containsKey('id') ? json['id'] : null;
        _latitude = json.containsKey('latitude') ? json['latitude'] : null;
        _longitude = json.containsKey('longitude') ? json['longitude'] : null;
        _bairro = json.containsKey('bairro') ? json['bairro'] : null;
        _rua = json.containsKey('rua') ? json['rua'] : null;
        _numero = json.containsKey('numero') ? json['numero'] : null;
        _ano = json.containsKey('ano') ? json['ano'] : null;
        _solicitacaoNumero = json.containsKey('solicitacao_numero') ? json['solicitacao_numero'] : null;
        _descricao = json.containsKey('descricao') ? json['descricao'] : null;
        _observacao = json.containsKey('observacao') ? json['observacao'] : null;
        _dataAbertura = json.containsKey('dataAbertura') ? json['dataAbertura'] : null;
        _dataFechamento = json.containsKey('dataFechamento') ? json['dataFechamento'] : null;
        _atendimentoIni = json.containsKey('atendimentoIni') ? json['atendimentoIni'] : null;
        _totalAtendimentos = json.containsKey('totalAtendimentos') ? json['totalAtendimentos'] : null;
        _minStatus = json.containsKey('minStatus') ? json['minStatus'] : null;
        _servicoNome = json.containsKey('servico_nome') ? json['servico_nome'] : null;
        _servicoIcone = json.containsKey('servico_icone') ? json['servico_icone'] : null;
        _servicoCor = json.containsKey('servico_cor') ? json['servico_cor'] : null;

        if (json.containsKey('anexo')) {
          _anexo = Anexo.fromJson(json['anexo']);
        }

      }
    } catch (e) {print("Colaboracao.fromJson");}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['id'] = this._id;
    json['latitude'] = this._latitude;
    json['longitude'] = this._longitude;
    json['bairro'] = this._bairro;
    json['rua'] = this._rua;
    json['numero'] = this._numero;
    json['ano'] = this._ano;
    json['solicitacao_numero'] = this._solicitacaoNumero;
    json['descricao'] = this._descricao;
    json['observacao'] = this._observacao;
    json['dataAbertura'] = this._dataAbertura;
    json['dataFechamento'] = this._dataFechamento;
    json['atendimentoIni'] = this._atendimentoIni;
    json['totalAtendimentos'] = this._totalAtendimentos;
    json['minStatus'] = this._minStatus;
    json['servico_nome'] = this._servicoNome;
    json['servico_icone'] = this._servicoIcone;
    json['servico_cor'] = this._servicoCor;
    json['anexo'] = this._anexo.toJson();
    return json;
  }
}
