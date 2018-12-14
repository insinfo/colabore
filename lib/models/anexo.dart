import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Anexo {

  int idAtendimentoHistorico;
  String nome;
  String extensao;
  String nomeFisico;
  String url;

  Anexo.fromJson(Map<String, dynamic> json) {
    idAtendimentoHistorico = json['idAtendimentoHistorico'];
    nome = json['nome'];
    extensao = json['extensao'];
    nomeFisico = json['nomeFisico'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['idAtendimentoHistorico'] = this.idAtendimentoHistorico;
    json['nome'] = this.nome;
    json['extensao'] = this.extensao;
    json['nomeFisico'] = this.nomeFisico;
    json['url'] = this.url;
    return json;
  }


}