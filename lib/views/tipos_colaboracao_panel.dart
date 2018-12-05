import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:colabore/models/tipo_colaboracao.dart';
import 'package:colabore/view_models/main_page_view_model.dart';
import 'package:colabore/views/tipo_colaboracao_list_item.dart';
import 'package:colabore/style.dart';

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
                  return Container(
                    color: AppStyle.backgroundDark,
                    child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: tiposColaboracao == null ? 0 : tiposColaboracao
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      var tipoColaboracao = tiposColaboracao[index];
                      return TipoColaboracaoListItem(
                          tipoColaboracao: tipoColaboracao);
                    },
                  ),);
                } else if (snapshot.hasError) {
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

