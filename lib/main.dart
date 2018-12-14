import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:colabore/models/usuario.dart';
import 'package:colabore/data/database_helper.dart';
import 'package:colabore/app_settings.dart';
import 'routes.dart';
import 'views/login_view.dart';

import 'package:colabore/utils/connection_check.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  MyApp(){
    isInternet();
    getToken();
  }

  Future isInternet() async{
    var r = await ConnectionCheck.isInternet();
    ConnectionCheck.asInternet = r;
  }

  void getToken() async {
    try {
      var db = new DatabaseHelper();
      var user = await db.getFistUser();
      if (user != null) {
        AppSettings.user = user;
        AppSettings.token = user.accessToken;
        debugPrint("main | carregou o token local ");
      } else {
        debugPrint("main | Erro ao obter token do sqlite");
      }
    }catch(e){
      debugPrint("main | Erro ao obter token do sqlite e: "+e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Colabore',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('es', 'ES'),
        const Locale('en', 'US'),
        const Locale('pt', 'BR')
      ],     
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue,
       // accentColor: Colors.lightBlue,
      ),
      home: LoginView(),
      routes: routes,
    );
  }
}
