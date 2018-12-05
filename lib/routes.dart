import 'package:flutter/material.dart';
import 'package:colabore/views/login_view.dart';
import 'package:colabore/views/home_view.dart';
import 'package:colabore/views/main_page.dart';
import 'package:colabore/views/sobre_view.dart';
import 'package:colabore/views/colaborar_view.dart';

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
  '/colaborar': (context) => ColaborarView(),
};