import 'package:colabore/models/colaboracao.dart';

class ColaboracaoReq {
  int _draw;
  int _recordsFiltered;
  int _recordsTotal;
  int _totalPages;
  int _page;

  List<Colaboracao> _listColaboracao;
  String _status;

  List<Colaboracao> get listColaboracao {
    return _listColaboracao;
  }

  set listColaboracao(List<Colaboracao> val) {
    _listColaboracao = val;
  }

  ColaboracaoReq.fromJson(Map<String, dynamic> json) {

    try {

      if(json != null) {

        _draw = json.containsKey('draw') ? json['draw'] : null;
        _recordsFiltered = json.containsKey('recordsFiltered') ? json['recordsFiltered'] : null;
        _recordsTotal = json.containsKey('recordsTotal') ? json['recordsTotal'] : null;
        _totalPages = json.containsKey('totalPages') ? json['totalPages'] : null;
        _page = json.containsKey('page') ? json['page'] : null;
        _status = json.containsKey('status') ? json['status'] : null;
        var data = json.containsKey('data') ? json['data'] : null;

        if (data != null) {
          _listColaboracao = new List<Colaboracao>();

          json['data'].forEach((v) {
            _listColaboracao.add(new Colaboracao.fromJson(v));

          });
        }
      }

    } catch (e) {
      print("ColaboracaoReq.fromJson " + e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['draw'] = this._draw;
    data['recordsFiltered'] = this._recordsFiltered;
    data['recordsTotal'] = this._recordsTotal;
    data['totalPages'] = this._totalPages;
    data['page'] = this._page;
    if (this._listColaboracao != null) {
      data['data'] = this._listColaboracao.map((v) => v.toJson()).toList();
    }
    data['status'] = this._status;
    return data;
  }
}
