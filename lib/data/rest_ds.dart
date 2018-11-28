import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:colabore/utils/network_util.dart';
import 'package:colabore/models/usuario.dart';
import 'package:colabore/app_settings.dart';

class RestDatasource {

  NetworkUtil _netUtil = new NetworkUtil();

  Future<Usuario> login(String username, String password) async {

    return _netUtil.post(AppSettings.rotaLogin, body: {
      "userName": username,
      "password": password
    }).then((dynamic res) {

      print(res.toString());

      return Usuario.fromJson(res);

    });


  }
}