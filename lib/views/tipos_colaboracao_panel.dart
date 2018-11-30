import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:colabore/models/tipo_colaboracao.dart';
import 'package:colabore/view_models/main_page_view_model.dart';



class TiposColaboracaoPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainPageViewModel>(
      builder: (context, child, model) {

        return FutureBuilder<List<TipoColaboracao>>(
          future: model.tiposColaboracao,
          builder: (_, AsyncSnapshot<List<TipoColaboracao>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(child: Text("Erro"));
              case ConnectionState.active:
                return Center(child: Text("Erro"));
              case ConnectionState.waiting:
                return Center(child: const CircularProgressIndicator());
              case ConnectionState.done:

                if (snapshot.hasData) {
                  var tiposColaboracao = snapshot.data;
                  return ListView.builder(
                    itemCount:
                        tiposColaboracao == null ? 0 : tiposColaboracao.length,
                    itemBuilder: (_, int index) {
                      var tipoColaboracao = tiposColaboracao[index];
                      return TipoColaboracaoListItem(
                          tipoColaboracao: tipoColaboracao);
                    },
                  );
                } else if (snapshot.hasError)
                {
                  return Center(child: Text("NoInternetConnection"));
                }


            } // switch
          },
        );


      },
    );
  }
}

class NoInternetConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 4.0),
              child: Text(
                "Sem Internet",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

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
