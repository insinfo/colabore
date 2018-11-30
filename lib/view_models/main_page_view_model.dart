import 'dart:async';
import 'package:scoped_model/scoped_model.dart';

import 'package:colabore/models/tipo_colaboracao.dart';
import 'package:colabore/services/tipo_colaboracao_service.dart';

class MainPageViewModel extends Model {

  //propriedade / atributo privado do objeto
  Future<List<TipoColaboracao>> _tiposColaboracao;

  //propriedade get publica do objeto
  Future<List<TipoColaboracao>> get tiposColaboracao {
    return _tiposColaboracao;
  }

  //propriedade set publica do objeto
  set tiposColaboracao(Future<List<TipoColaboracao>> value) {
    _tiposColaboracao = value;
    notifyListeners();
  }

  ColaboracaoService apiRest;

  MainPageViewModel(){
    apiRest = new ColaboracaoService();
  }


  Future<bool> setTiposColaboracao() async {
    var re = apiRest?.getTiposColaboracao();
    if(re != null){
      tiposColaboracao = re;
    }
    return tiposColaboracao != null;
  }

}