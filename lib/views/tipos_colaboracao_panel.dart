import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:colabore/models/tipo_colaboracao.dart';
import 'package:colabore/view_models/main_page_view_model.dart';
import 'package:colabore/views/tipo_colaboracao_list_item.dart';
import 'package:colabore/style.dart';

class TiposColaboracaoPanel extends StatelessWidget {

  MainPageViewModel _model;
  BuildContext _context;
  var _refreshKey = GlobalKey<RefreshIndicatorState>();
  var _scrollController = new ScrollController();

  Future _refresh() async {
    _refreshKey.currentState?.show();
    await _model.setTiposColaboracao();
    print("on pull to refresh");
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainPageViewModel>(
      builder: (context, child, model) {
        return FutureBuilder<List<TipoColaboracao>>(
          future: model.tiposColaboracao,
          builder: (_, AsyncSnapshot<List<TipoColaboracao>> snapshot) {
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
                  var tiposColaboracao = snapshot.data;

                  return Container(
                    color: AppStyle.backgroundDark,
                    child: RefreshIndicator(
                        key: _refreshKey,
                        onRefresh: _refresh,
                        child: ListView.builder(
                            controller: _scrollController,
                           // scrollDirection: Axis.vertical,
                            itemCount: tiposColaboracao == null ? 0 : tiposColaboracao
                                .length,
                            itemBuilder: (BuildContext context, int index) {
                              var tipoColaboracao = tiposColaboracao[index];
                              return TipoColaboracaoListItem(
                                  tipoColaboracao: tipoColaboracao);
                            },
                          ),
                        )
                  );
                }

                return Center(child: Text('Result: ${snapshot.error}'));

            } // switch
          },
        );
      },
    );
  }
}



