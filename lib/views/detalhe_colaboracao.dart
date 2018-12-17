import 'package:flutter/material.dart';
import 'dart:async';
import 'package:colabore/services/tipo_colaboracao_service.dart';

import 'package:colabore/view_models/main_page_view_model.dart';
import 'package:colabore/models/tipo_colaboracao.dart';
import 'package:colabore/models/colaboracao.dart';
import 'package:colabore/app_settings.dart';
import 'package:colabore/style.dart';
import 'dart:io';
import 'package:flutter/services.dart';


import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';


class DetalheColaboracaoView extends StatefulWidget {

  final Colaboracao colaboracao;

  DetalheColaboracaoView({Key key, @required this.colaboracao}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new DetalheColaboracaoViewState(colaboracao: colaboracao);
  }
}


class DetalheColaboracaoViewState extends State<DetalheColaboracaoView> {

  final Colaboracao colaboracao;

  DetalheColaboracaoViewState({@required this.colaboracao});

  Widget _buildMap(latitude, longitude) {

    var pos = new LatLng(latitude,longitude);

    return new FlutterMap(
      options: new MapOptions(
        center: pos,
        zoom: 18,
      ),
      layers: [

        new TileLayerOptions(
          /*urlTemplate: "https://api.tiles.mapbox.com/v4/""{id}/{z}/{x}/{y}@2x.png?access_token=${AppSettings.mapboxAccessToken}",
          additionalOptions: {
            'accessToken': '<${AppSettings.mapboxAccessToken}>',
            'id': 'mapbox.streets',
          },*/
            urlTemplate:"http://a.tile.openstreetmap.org/{z}/{x}/{y}.png"
        ),

        new MarkerLayerOptions(
          markers: [
            new Marker(
              width: 80.0,
              height: 80.0,
              point: pos,
              builder: (ctx) =>
              new Container(
                child: Icon(Icons.location_on,color: Colors.red,size: 40,),
              ),
            ),
          ],
        ),

      ],
    );
  }

  _listItem(String label,String value){
    return Container(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 3),
      child: Row(children: <Widget>[
          Text(
            "$label:  ",
            style: TextStyle(color: AppStyle.textMedium, fontSize: 14),
          ),
          Text(
            value,
            style: TextStyle(color: Colors.white, fontSize: 16),
          )
        ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Colaboração"),
        backgroundColor: AppStyle.backgroundDark,
        elevation: 0,
      ),
      backgroundColor: AppStyle.backgroundDark,
      body: new Center(
        child: ListView(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
          children: <Widget>[

          Container(
            padding: EdgeInsets.fromLTRB(70, 16, 70, 16),
            color: Colors.white12,
            child: colaboracao.getImageURL != null ?
              Image.network(colaboracao.getImageURL,height: 180,) : Container()
          ),

          _listItem("Nº",colaboracao.getNumeroSolicitacao),
          _listItem("Serviço",colaboracao.getNomeServico),
          _listItem("Status",colaboracao.getStatusAsString),
          _listItem("Aberto",colaboracao.getDataAbertura),
          _listItem("Rua",colaboracao.getRua),
          _listItem("Bairro",colaboracao.getBairro),
          _listItem("Fechado",colaboracao.getDataFechamento),


          Container(
              padding: EdgeInsets.fromLTRB(0, 7, 0, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Descrição:  ",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: AppStyle.textMedium, fontSize: 14),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: Text(
                        colaboracao.getDescricao,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 20,
                        style: TextStyle(color: AppStyle.textLight,fontSize: 17),
                      ),
                    ),
                  ]),
                ],
              )
          ),


          //mapa
          Container(
            width: 150,height: 300,
            padding: EdgeInsets.fromLTRB(0, 20, 0, 50),
            child: _buildMap(colaboracao.getLatitude,colaboracao.getLongitude),
          ),


          Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 50),
                child: Image.asset('assets/pmro2018-logo.png',width: 120,),
              )
          ),

        ],)
      ),
    );
  }
}
