import 'package:flutter/material.dart';
import 'package:colabore/models/colaboracao.dart';
import 'package:colabore/style.dart';

class ColaboracaoListItem extends StatelessWidget {
  final Colaboracao colaboracao;

  ColaboracaoListItem({@required this.colaboracao});

  @override
  Widget build(BuildContext context) {
    final makeListTile = ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        /*leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.check, color: Colors.white),
        ),*/

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //lina 1
            Row(children: <Widget>[
              Text(
                "Nº:  ",
                style: TextStyle(color: AppStyle.textMedium, fontSize: 12),
              ),
              Text(
                colaboracao?.codigo,
                style: TextStyle(color: Colors.white, fontSize: 14),
              )
            ]),

            Padding(
              padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
            ),

            //lina 2
            Row(children: <Widget>[
              Text(
                "Rua:  ",
                style: TextStyle(color: AppStyle.textMedium, fontSize: 12),
              ),
              Text(
                colaboracao?.rua,
                style: TextStyle(color: AppStyle.textLight, fontSize: 14),
              )
            ]),

            Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Bairro:  ",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(color: AppStyle.textMedium, fontSize: 12),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                    ),
                    Text(colaboracao.bairro,
                        style: TextStyle(color: Colors.white, fontSize: 12))
                  ]),
            ),
          ],
        ),
        subtitle: Container(
            padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Descrição:  ",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: AppStyle.textMedium, fontSize: 12),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                ),
                Row(children: <Widget>[
                  Expanded(
                    child: Text(
                      colaboracao.descricao,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(color: AppStyle.textLight),
                    ),
                  ),
                ]),
              ],
            )),
        trailing: Icon(Icons.keyboard_arrow_right,
            color: AppStyle.textLight, size: 30.0));

    final makeCard = Card(
      elevation: 4.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      shape: Border(left: BorderSide(width: 2.0, color: Colors.blue)),
      child: Container(
          decoration: BoxDecoration(color: AppStyle.backgroundCard),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              makeListTile,
              Container(
                width: double.maxFinite,height: 30,
                padding: EdgeInsets.fromLTRB(10, 5, 10, 3),
                color: Color.fromRGBO(64, 75, 96, .9),
                child: Row(children: <Widget>[

                  Text(
                    "Status:  ",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppStyle.textMedium,
                      fontSize: 12,
                    ),
                  ),

                  Text(
                    colaboracao.statusFinal,
                    style: TextStyle(
                    color: AppStyle.textLight,
                    fontSize: 13,
                  ),)

                ],)
              )
            ],
          )),
    );

    return makeCard;
  }
}
