import 'package:flutter/material.dart';
import 'package:colabore/app_settings.dart';
import 'package:colabore/style.dart';

class MenuPrincipal extends StatelessWidget {

  @override
  Widget build (BuildContext context){
    return Drawer(
      // Adicione um ListView à gaveta/Drawer. Isso garante que o usuário possa rolar
      // através das opções na gaveta se não houver espaço vertical suficiente
      //  para ajustar tudo.
      child: Container(
        color: AppStyle.backgroundDark,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(AppSettings.user?.fullName),
              accountEmail: Text(AppSettings.user?.loginName),
              currentAccountPicture: CircleAvatar(
                backgroundImage:
                AppSettings.user?.avatarUrl == null ?
                AssetImage('assets/userAvatar.png')
                : NetworkImage(AppSettings.user?.avatarUrl),

                //child: AppSettings.user?.avatarUrl == null ?  Text('AH') : null,
              ),
              decoration: BoxDecoration(
                color: AppStyle.backgroundDark,
              ),
              //padding: EdgeInsets.all(20),
            ),
            ListTile(
              leading: Icon(Icons.info,color: AppStyle.menuIcon,),
              title: Text('Sobre',style: TextStyle(color: AppStyle.textLight),),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed("/sobre");
              },
            ),
            ListTile(
              leading: Icon(Icons.comment,color: AppStyle.menuIcon,),
              title: Text('Política e Termos',style: TextStyle(color: AppStyle.textLight),),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed("/politica");
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app,color: AppStyle.menuIcon,),
              title: Text('Sair',style: TextStyle(color: AppStyle.textLight),),
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
}