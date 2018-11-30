import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:colabore/view_models/main_page_view_model.dart';
import 'package:colabore/views/tipos_colaboracao_panel.dart';
import 'package:colabore/models/tipo_colaboracao.dart';
import 'package:colabore/data/database_helper.dart';
import 'package:colabore/app_settings.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  MainPageViewModel viewModel;
  TabController tabController;
  BuildContext _ctx;

  @override
  void initState() {
    super.initState();
    viewModel = new MainPageViewModel();
    tabController = TabController(vsync: this, length: 2);
    loadData();
  }

  Future loadData() async {
    await viewModel.setTiposColaboracao();
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Jubarte',
          style: TextStyle(color: Colors.white
              //fontFamily: 'Distant Galaxy',
              ),
        ),
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.white,
          //labelStyle: TextStyle(color: Colors.white),
          labelColor: Colors.white,
          indicatorWeight: 3.0,
          tabs: <Widget>[
            /*Tab(icon: Icon(FontAwesomeIcons.film)),
            Tab(icon: Icon(FontAwesomeIcons.users)),*/
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
            Container(),
            //TiposColaboracaoPanel(),
          ],
        ),
      ),
      drawer: Drawer(
        // Adicione um ListView à gaveta/Drawer. Isso garante que o usuário possa rolar
        // através das opções na gaveta se não houver espaço vertical suficiente
        //  para ajustar tudo.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(AppSettings.user?.fullName),
              accountEmail: Text(AppSettings.user?.loginName),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(AppSettings.user?.getAvatarUrl()),
                //child: Text('AH'),
              ),
              /*decoration: BoxDecoration(
                color: Colors.blue,
              ),*/
              //padding: EdgeInsets.all(20),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Sobre'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app,color: Colors.blue,),
              title: Text('Sair',style: TextStyle(),),
              onTap: () {
                Navigator.pop(context);
                AppSettings.logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }
}
