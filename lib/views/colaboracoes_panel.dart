import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:colabore/view_models/main_page_view_model.dart';
import 'package:colabore/models/colaboracao.dart';
import 'package:colabore/views/colaboracao_list_item.dart';
import 'package:colabore/style.dart';
import 'package:colabore/utils/connection_check.dart';

class ColaboracoesPanel extends StatelessWidget {

  MainPageViewModel _model;
  BuildContext _context;
  var _refreshKey = GlobalKey<RefreshIndicatorState>();
  var _scrollController = new ScrollController();

  /*void _state(){
    _scrollController.addListener(
            () {

              if(_scrollController != null){

                double maxScroll = _scrollController.position.maxScrollExtent;
                double currentScroll = _scrollController.position.pixels;
                double delta = 0; // or something else..
                if ( maxScroll - currentScroll <= delta) { // whatever you determine here
                    //.. load more
                    print("fim da lista  load more 2");
                }

              }

            }
        );
  }*/

  Future _refresh() async {
      _refreshKey.currentState?.show();
      await _model.setColaboracoes();
      print("on pull to refresh");
  }

  _buildList(){
    return FutureBuilder<List<Colaboracao>>(
      future: _model.colaboracoes,
      builder: (_, AsyncSnapshot<List<Colaboracao>> snapshot) {
        print("teste");
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
                  color: AppStyle.backgroundDark,
                  child: RefreshIndicator(
                    key: _refreshKey,
                    onRefresh: _refresh,
                    child: ListView.builder(
                      controller: _scrollController,
                      //  scrollDirection: Axis.vertical,
                      itemCount: colaboracoes == null ? 0 : colaboracoes.length,
                      itemBuilder: (BuildContext context, int index) {
                        var colaboracao = colaboracoes[index];
                        return ColaboracaoListItem(colaboracao: colaboracao);
                      },
                    ),
                  )
              );

            }

            return Center(child: Text('Result: ${snapshot.error}'));

        } // switch
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainPageViewModel>(
      builder: (context, child, model) {
        _model = model;
        _context = context;
        //_state();
        return _buildList();
      },
    );
  }
}
