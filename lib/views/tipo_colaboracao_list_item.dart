import 'package:flutter/material.dart';
import 'package:colabore/models/tipo_colaboracao.dart';

class TipoColaboracaoListItem extends StatelessWidget {
  final TipoColaboracao tipoColaboracao;

  TipoColaboracaoListItem({@required this.tipoColaboracao});

  @override
  Widget build(BuildContext context) {

    var title = Text(
      tipoColaboracao?.nome,
      style: TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    var subTitle = Row(
      children: <Widget>[
        Icon(
          Icons.movie,
          color: Colors.green,
          size: 13,
        ),
        Container(
          margin: const EdgeInsets.only(left: 4.0),
          child: Text(
            tipoColaboracao?.descricao,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );

    return Column(
      children: <Widget>[
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          title: title,
          subtitle: subTitle,
        ),
        Divider(),
      ],
    );
  }
}
