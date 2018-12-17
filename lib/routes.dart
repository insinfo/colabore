import 'package:flutter/material.dart';
import 'package:colabore/views/login_view.dart';
import 'package:colabore/views/no_internet_view.dart';
import 'package:colabore/views/main_page.dart';
import 'package:colabore/views/sobre_view.dart';
import 'package:colabore/views/colaborar_view.dart';
import 'package:colabore/views/cadastro_view.dart';
import 'package:colabore/views/detalhe_colaboracao.dart';
import 'package:colabore/views/politica_view.dart';
import 'package:colabore/views/recupera_acesso_view.dart';
/*
final routes = {
  '/login': (BuildContext context) => new LoginView(),
  '/home': (BuildContext context) => new HomeView(),
  '/': (BuildContext context) => new LoginView(),
};

final routes = <String, WidgetBuilder>{
    LoginView.tag: (context) => LoginView(),
    //'/home': (context) => HomePage(),
  };

*/

final routes = <String, WidgetBuilder>{
  '/login': (context) => LoginView(),
  '/home': (context) => MainPage(),
  '/sobre': (context) => SobreView(),
  '/cadastro': (context) => CadastroView(),
  '/noInternet': (context) => NoInternetView(),
  '/politica': (context) => PoliticaView(),
  '/recuperarAcesso': (context) => RecuperaAcessoView(),
  //'/detalheColaboracao': (context) => DetalheColaboracaoView(),
};