import 'package:flutter/material.dart';
import 'dart:async';
import 'package:colabore/services/tipo_colaboracao_service.dart';

import 'package:colabore/view_models/main_page_view_model.dart';
import 'package:colabore/models/tipo_colaboracao.dart';
import 'package:colabore/app_settings.dart';
import 'package:colabore/style.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class NoInternetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      appBar: null,backgroundColor: AppStyle.backgroundDark,
      body: new Center(
        child: ListView(children: <Widget>[

          Padding(
            padding: EdgeInsets.fromLTRB(70, 16, 70, 16),
            child: Image.asset('assets/jubarteLogo.png',width: 20,),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 50),
            child:
              Text("Detectamos que você esta sem internet, verifique a sua conexão e tente novamente."
              ,style: TextStyle(fontSize: 20),textAlign: TextAlign.center,)
            ,),

          Padding(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 50),
            child:
              RaisedButton(
                  child: Text("Sair"),
                  onPressed: () async {
                    //exit(0);
                    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  }
                ),
            ),

          Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Image.asset('assets/pmro2018-logo.png',width: 120,),
              )
          ),

        ],)
      ),
    );
  }
}
