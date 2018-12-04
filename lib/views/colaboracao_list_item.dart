import 'package:flutter/material.dart';
import 'package:colabore/models/colaboracao.dart';

class ColaboracaoListItem extends StatelessWidget {
  final Colaboracao colaboracao;

  ColaboracaoListItem({@required this.colaboracao});

  @override
  Widget build(BuildContext context) {
    
    var title = Text(
      colaboracao?.codigo,
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
            colaboracao?.bairro,
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
