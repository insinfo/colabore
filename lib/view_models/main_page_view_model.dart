import 'dart:async';
import 'package:scoped_model/scoped_model.dart';

import 'package:colabore/models/tipo_colaboracao.dart';
import 'package:colabore/services/tipo_colaboracao_service.dart';
import 'package:colabore/models/colaboracao.dart';

class MainPageViewModel extends Model {

  //propriedades / atributos privados do objeto
  Future<List<TipoColaboracao>> _tiposColaboracao;
  Future<List<Colaboracao>> _colaboracoes;

  //propriedades get publica do objeto 
  //lista tipos de colaboração ou seja serviços disponiveis pro usuario solicitar
  Future<List<TipoColaboracao>> get tiposColaboracao {
    return _tiposColaboracao;
  }

  //lista colaborações feitas pelo usuario
  Future<List<Colaboracao>> get colaboracoes {
    return _colaboracoes;
  }

  //propriedade set publica do objeto
  set tiposColaboracao(Future<List<TipoColaboracao>> value) {
    _tiposColaboracao = value;
    notifyListeners();
  }

  set colaboracoes(Future<List<Colaboracao>> value) {
    _colaboracoes = value;
    notifyListeners();
  }

  ColaboracaoService apiRest;

  MainPageViewModel(){
    apiRest = new ColaboracaoService();
  }

  //metodos para popular o objeto
  Future<bool> setTiposColaboracao() async {
    var re = apiRest?.getTiposColaboracao();
    if(re != null){
      tiposColaboracao = re;
    }
    return tiposColaboracao != null;
  }

  Future<bool> setColaboracoes() async {
    var re = apiRest?.getColaboracoes();
    if(re != null){
      colaboracoes = re;
    }
    return colaboracoes != null;
  }

}