import 'package:colabore/models/tipo_colaboracao.dart';

class TipoColaboracaoReq {
  int _draw;
  int _recordsFiltered;
  int _recordsTotal;
  int _totalPages;
  int _page;

  List<TipoColaboracao> _listTipoColaboracao;
  String _status;

  List<TipoColaboracao> get listTipoColaboracao {
    return _listTipoColaboracao;
  }

  set listTipoColaboracao(List<TipoColaboracao> val) {
    _listTipoColaboracao = val;
  }

  TipoColaboracaoReq.fromJson(Map<String, dynamic> json) {

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
          _listTipoColaboracao = new List<TipoColaboracao>();

          json['data'].forEach((v) {
            _listTipoColaboracao.add(new TipoColaboracao.fromJson(v));

          });
        }
      }

    } catch (e) {
      print("TipoColaboracaoReq.fromJson " + e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['draw'] = this._draw;
    data['recordsFiltered'] = this._recordsFiltered;
    data['recordsTotal'] = this._recordsTotal;
    data['totalPages'] = this._totalPages;
    data['page'] = this._page;
    if (this._listTipoColaboracao != null) {
      data['data'] = this._listTipoColaboracao.map((v) => v.toJson()).toList();
    }
    data['status'] = this._status;
    return data;
  }
}
