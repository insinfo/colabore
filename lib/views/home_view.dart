import 'package:flutter/material.dart';
import 'dart:async';
import 'package:colabore/services/tipo_colaboracao_service.dart';

import 'package:colabore/view_models/main_page_view_model.dart';
import 'package:colabore/models/tipo_colaboracao.dart';
import 'package:colabore/app_settings.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
      ),
      body: new Center(
        child: RaisedButton(child: Text("teste"), 
            onPressed: () async {
              AppSettings.logout(context);
            }),
      ),
    );
  }
}
