import 'package:flutter/material.dart';
import 'package:colabore/models/tipo_colaboracao.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:colabore/views/icons.dart';
import 'package:colabore/views/colaborar_view.dart';

class TipoColaboracaoListItem extends StatelessWidget {
  final TipoColaboracao tipoColaboracao;

  TipoColaboracaoListItem({@required this.tipoColaboracao});

  @override
  Widget build(BuildContext context) {
    final makeListTile = ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child:Icon(tipoColaboracao.getIcon, color: Colors.white)
        ),
        title: Text(
          tipoColaboracao?.getNome,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: <Widget>[
            Icon(Icons.linear_scale, color: Colors.yellowAccent),
            Text("Serviço da Prefeitura",
                style: TextStyle(color: Colors.white, fontSize: 12))
          ],
        ),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0));

    final makeCard = Card(
      elevation: 4.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: makeListTile,
      ),
    );

    return InkWell(
      onTap: () {
        //Navigator.of(context).pushNamed("/colaborar");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ColaborarView(tipoColaboracao:tipoColaboracao)
          ),
        );

      },
      child: makeCard,
    );
  }
}
