import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:colabore/view_models/main_page_view_model.dart';
import 'package:colabore/views/tipos_colaboracao_panel.dart';
import 'package:colabore/models/tipo_colaboracao.dart';
import 'package:colabore/data/database_helper.dart';
import 'package:colabore/app_settings.dart';
import 'package:colabore/views/menu.dart';
import 'package:colabore/style.dart';
import 'package:colabore/views/colaboracao_list_item.dart';
import 'package:colabore/views/colaboracoes_panel.dart';

import 'package:colabore/utils/connection_check.dart';
import 'dart:io';
import 'dart:async';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:colabore/app_strings.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  MainPageViewModel viewModel;
  TabController tabController;
  BuildContext _ctx;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    viewModel = new MainPageViewModel();
    tabController = TabController(vsync: this, length: 2);
    isInternet();
    loadData();
    initPermissions();
  }

  initPermissions() async {
    try {

      //SimplePermissions.requestPermission(Permission.AccessFineLocation);

      var hasPermission = await SimplePermissions.checkPermission(Permission.AlwaysLocation);
      print("tem a permissão "+hasPermission.toString());

      if(hasPermission == false) {
        var isPermited = await SimplePermissions.requestPermission(Permission.AlwaysLocation);

        if(isPermited != PermissionStatus.authorized ){
          _showDialog(AppStrings.userNotAuthorizedGPS);
        }
      }

      //print(re);
      /*_isLocationPermission = await _location.hasPermission();
      var location = await _location.getLocation();
      _locationSubscription = _location.onLocationChanged().listen(_onLocationChange);
      _currentLocation = await _location.getLocation();*/


    }catch(e){
    }
  }

  void _showDialog(String message,{Function onPressed}) {
    // flutter defined function
    showDialog(
      context: _ctx,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Atenção"),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
                if(onPressed != null){
                  onPressed();
                }
                //Navigator.of(context).pushNamed("/home");
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose(){
    super.dispose();
    tabController?.dispose();
  }

  Future isInternet() async{
   var r = await ConnectionCheck.isInternet();
   ConnectionCheck.asInternet = r;
   if(r == false) {
     Navigator.of(_ctx).pushNamed("/noInternet");
   }
  }

  Future loadData() async {
    await viewModel.setTiposColaboracao();
    await viewModel.setColaboracoes();
  }

  void _showSnackBar(String text) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppStyle.backgroundAppBar,
          title: Text(
            'Jubarte',
            style: TextStyle(color: AppStyle.textLight),
          ),
          centerTitle: true,
          bottom: TabBar(
            controller: tabController,
            indicatorColor: AppStyle.tabIndicator,
            labelColor: AppStyle.textLight,
            indicatorWeight: 2.0,
            tabs: <Widget>[
              Tab(
                text: "Serviços",
              ),
              Tab(
                text: "Colaborações",
              ),
            ],
          ),
        ),
        body: ScopedModel<MainPageViewModel>(
          model: viewModel,
          child: TabBarView(
            controller: tabController,
            children: <Widget>[
              TiposColaboracaoPanel(),
              ColaboracoesPanel()
            ],
          ),
        ),
        drawer: MenuPrincipal());
  }


}
