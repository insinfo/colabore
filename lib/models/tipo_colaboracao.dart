import 'package:flutter/material.dart';
import 'package:colabore/views/icons.dart';

class TipoColaboracao {
  int _id;
  String _cor;
  String _icone;
  String _nome;
  String _descricao;
  int _idSetor;

  IconData get getIcon {
    try {
      if (_icone == null) {
        return Icons.check;
      } else if (IconsMap.containsKey(_icone)) {
        return IconsMap[_icone];
      } else if (FontAwesomeIconsMap.containsKey(_icone)) {
        return FontAwesomeIconsMap[_icone];
      }else{
        return Icons.check;
      }
    } catch (e) {
      return Icons.check;
    }
  }

  int get getId {
    return _id;
  }

  int get getIdSetor {
    return _idSetor;
  }

  String get getNome {
    try {
      if (_nome == null) {
        return " - ";
      }
      return _nome;
    } catch (e) {
      return " - ";
    }
  }

  String get getDescricao {
    try {
      if (_descricao == null) {
        return " - ";
      }
      return _descricao;
    } catch (e) {
      return " - ";
    }
  }

  MaterialColor get getColor {
    try {
      return Colors.red;
    } catch (e) {
      return Colors.blue;
    }
  }

  TipoColaboracao.fromJson(Map<String, dynamic> json) {
    try {
      if (json != null) {
        _id = json.containsKey('id') ? json['id'] : null;
        _cor = json.containsKey('cor') ? json['cor'] : null;
        _icone = json.containsKey('icone') ? json['icone'] : null;
        _nome = json.containsKey('nome') ? json['nome'] : null;
        _descricao = json.containsKey('descricao') ? json['descricao'] : null;
        _idSetor = json.containsKey('idSetor') ? json['idSetor'] : null;
      }
    }catch(e){
      print("TipoColaboracao.fromJson "+e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['cor'] = this._cor;
    data['icone'] = this._icone;
    data['nome'] = this._nome;
    data['descricao'] = this._descricao;
    data['idSetor'] = this._idSetor;
    return data;
  }
}
