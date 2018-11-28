import 'package:colabore/models/tipo_colaboracao.dart';

class TipoColaboracaoReq {
  int draw;
  int recordsFiltered;
  int recordsTotal;
  int totalPages;
  int page;
  List<TipoColaboracao> data;

  TipoColaboracaoReq(
      {this.draw,
      this.recordsFiltered,
      this.recordsTotal,
      this.totalPages,
      this.page,
      this.data});

  TipoColaboracaoReq.fromJson(Map<String, dynamic> json) {
    draw = json['draw'];
    recordsFiltered = json['recordsFiltered'];
    recordsTotal = json['recordsTotal'];
    totalPages = json['totalPages'];
    page = json['page'];
    if (json['data'] != null) {
      data = new List<TipoColaboracao>();
      json['data'].forEach((v) {
        data.add(new TipoColaboracao.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['draw'] = this.draw;
    data['recordsFiltered'] = this.recordsFiltered;
    data['recordsTotal'] = this.recordsTotal;
    data['totalPages'] = this.totalPages;
    data['page'] = this.page;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
