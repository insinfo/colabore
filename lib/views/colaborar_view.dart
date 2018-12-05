import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:colabore/models/tipo_colaboracao.dart';
import 'package:colabore/style.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';

import 'package:image_picker/image_picker.dart';

class ColaborarView extends StatefulWidget {
  final TipoColaboracao tipoColaboracao;

  ColaborarView({Key key, @required this.tipoColaboracao}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ColaborarViewState(tipoColaboracao: tipoColaboracao);
  }
}

class ColaborarViewState extends State<ColaborarView> {
  BuildContext _ctx;
  final TipoColaboracao tipoColaboracao;
  List<String> _bairros = <String>["","Centro","Ancora"];
  String _bairro = '';

  ColaborarViewState({@required this.tipoColaboracao});

  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    print(image.path);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    return Scaffold(
        appBar:  new AppBar(
          title: new Text("Colaborar"),
          backgroundColor: AppStyle.backgroundDark,elevation: 0,
        ),
        key: _scaffoldKey,
        backgroundColor: AppStyle.backgroundDark, //#3b4455
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: _formKey,
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[

                  Ink(
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.indigoAccent, width: 2),
                      color: Colors.lightBlue,
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      //This keeps the splash effect within the circle
                      borderRadius: BorderRadius.circular(1000.0), //Something large to ensure a circle
                      onTap: getImage,
                      child: Padding(
                        padding:EdgeInsets.all(20.0),
                        child: Icon(
                          Icons.photo_camera,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),


                  //bairro
                  new FormField(
                    builder: (FormFieldState state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.add_location),
                          labelText: 'Bairro',
                        ),
                        isEmpty: _bairro == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton(
                            value: _bairro,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {

                                _bairro = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: _bairros.map((String value) {
                              return new DropdownMenuItem(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  //Logradouro
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.location_on),
                      hintText: 'Digite o nome da sua rua',
                      labelText: 'Logradouro',
                    ),
                  ),

                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.location_on),
                      hintText: 'Digite o número da sua casa',
                      labelText: 'Número',
                    ),
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                  ),

                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.comment),
                      hintText: 'Preencha com uma breve descrição',
                      labelText: 'Descrição',
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                  ),


                  new Container(
                      padding: const EdgeInsets.only(left: 0, top: 20.0),
                      child: new RaisedButton(
                        color: AppStyle.buttonPrimary,
                        child: const Text('Colaborar'),
                        onPressed: (){},
                      )),
                ],
              ))),
    );
  }
}