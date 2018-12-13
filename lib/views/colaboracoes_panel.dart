import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:colabore/view_models/main_page_view_model.dart';
import 'package:colabore/models/colaboracao.dart';
import 'package:colabore/views/colaboracao_list_item.dart';
import 'package:colabore/style.dart';

class ColaboracoesPanel extends StatelessWidget {

  MainPageViewModel _model;
  BuildContext _context;
  var _refreshKey = GlobalKey<RefreshIndicatorState>();

  Future _refresh() async {
      _refreshKey.currentState?.show();
      await _model.setColaboracoes();
      print("on pull to refresh");
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainPageViewModel>(
      builder: (context, child, model) {
        _model = model;
        _context = context;

        return FutureBuilder<List<Colaboracao>>(
          future: model.colaboracoes,
          builder: (_, AsyncSnapshot<List<Colaboracao>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(child: Text('Presione o botão para iniciar'));
              case ConnectionState.active:
                return Center(child: Text("Ativo"));
              case ConnectionState.waiting:
                return Container(
                  /*height: double.infinity,
                  width: double.infinity,*/
                   color: AppStyle.backgroundDark,
                  child:Center(child:  CircularProgressIndicator()),                
                );
              case ConnectionState.done:
                if (!snapshot.hasError) {
                  var colaboracoes = snapshot.data;

                  return Container(
                    key: _refreshKey,
                    color: AppStyle.backgroundDark,
                    child: RefreshIndicator(
                    onRefresh: _refresh,
                      child: ListView.builder(
                      itemCount: colaboracoes == null ? 0 : colaboracoes.length,
                      itemBuilder: (_, int index) {
                        var colaboracao = colaboracoes[index];
                        return ColaboracaoListItem(colaboracao: colaboracao);
                      },
                    ),
                    )
                  );

                } else  {
                  return Center(child: Text('Result: ${snapshot.error}'));
                }
            } // switch
          },
        );


      },
    );
  }
}
