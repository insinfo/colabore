import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:colabore/view_models/main_page_view_model.dart';
import 'package:colabore/models/colaboracao.dart';
import 'package:colabore/views/colaboracao_list_item.dart';
import 'package:colabore/style.dart';

class ColaboracoesPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainPageViewModel>(
      builder: (context, child, model) {
        return FutureBuilder<List<Colaboracao>>(
          future: model.colaboracoes,
          builder: (_, AsyncSnapshot<List<Colaboracao>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(child: Text("Erro"));

              case ConnectionState.active:
                return Center(child: Text("Erro"));
              case ConnectionState.waiting:
                return Center(child: const CircularProgressIndicator());
              case ConnectionState.done:
                if (snapshot.hasData) {
                  var colaboracoes = snapshot.data;

                  return Container(
                    color: AppStyle.backgroundDark,
                    child: ListView.builder(
                      itemCount: colaboracoes == null ? 0 : colaboracoes.length,
                      itemBuilder: (_, int index) {
                        var colaboracao = colaboracoes[index];
                        return ColaboracaoListItem(colaboracao: colaboracao);
                      },
                    ),
                  );

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
