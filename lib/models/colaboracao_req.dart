import 'package:colabore/models/colaboracao.dart';
class ColaboracaoReq {
  int draw;
  int recordsFiltered;
  int recordsTotal;
  int totalPages;
  int page;

  List<Colaboracao> data;
  String status;

  ColaboracaoReq(
      {
        this.draw,
        this.recordsFiltered,
        this.recordsTotal,
        this.totalPages,
        this.page,
        this.data,
        this.status
      });

  ColaboracaoReq.fromJson(Map<String, dynamic> json) {
    draw = json['draw'];
    recordsFiltered = json['recordsFiltered'];
    recordsTotal = json['recordsTotal'];
    totalPages = json['totalPages'];
    page = json['page'];
    if (json['data'] != null) {
      data = new List<Colaboracao>();
      json['data'].forEach((v) {
        data.add(new Colaboracao.fromJson(v));
      });
    }
    status = json['status'];
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
    data['status'] = this.status;
    return data;
  }
}
