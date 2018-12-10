import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:colabore/models/tipo_colaboracao.dart';
import 'package:colabore/style.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:path/path.dart';


import 'package:colabore/widgets/modal_progress_indicator.dart';
import 'package:location/location.dart';
import 'package:colabore/services/tipo_colaboracao_service.dart';
import 'package:colabore/models/colaborar.dart';
import 'package:colabore/app_settings.dart';
import 'package:colabore/widgets/dropdown_form_field.dart';

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
  List<String> _bairros = <String>["Centro", "Ancora"];
  var apiRest = new ColaboracaoService();

  Map<String, double> _startLocation;
  Map<String, double> _currentLocation;
  StreamSubscription<Map<String, double>> _locationSubscription;
  Location _location = new Location();
  bool _permission = false;
  String error;
  bool _autoValidate = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _locationSubscription =
        _location.onLocationChanged().listen((Map<String, double> result) {
        _currentLocation = result;
    });
  }

  initPlatformState() async {
    Map<String, double> location;

    try {
      var bairros = await apiRest.getBairros();
      setState(() {
        _bairros = bairros;
      });
      _permission = await _location.hasPermission();
      location = await _location.getLocation();

      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
            'Permission denied - please ask the user to enable it from the app settings';
      }
      print(e.message);
      location = null;
    }
    _currentLocation = await _location.getLocation();
    setState(() {
      _startLocation = location;
    });

  }

  ColaborarViewState({@required this.tipoColaboracao});

  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  var colaborar = new Colaborar();

  File _imageFile;
  //3748 38562
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera,maxHeight: 480,maxWidth: 640,quality: 0.5);

    print( await image.length());
    setState(() {
      _imageFile = image;
    });
  }

  bool _saving = false;
  bool _isProcessing = false;

  void _showSnackBar(String text) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  void _showDialog(String message) {
    // flutter defined function
    showDialog(
      context: _ctx,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Concluido"),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _submit() async {
    /* 
    print(currentLocation["latitude"]);
    print(currentLocation["longitude"]);
    print(currentLocation["accuracy"]);
    print(currentLocation["altitude"]);
    print(currentLocation["speed"]);
    print(currentLocation["speed_accuracy"]);
    */

    final form = _formKey.currentState;

    if(_imageFile == null){
      _showSnackBar("Você não tirou uma foto!");
      return;
    }

    setState(() => _isProcessing = true);

    if(_currentLocation == null){
      _showSnackBar("Você não autorizou o uso da localização!");
      return;
    }

    setState(() {
      _autoValidate = true;
    });

    if (form.validate()) {
      setState(() => _saving = true);
      form.save();

      //obtem as coordenadas de GPS
      colaborar.latitude = _currentLocation["latitude"];
      colaborar.longitude = _currentLocation["longitude"];

      //obtem a imagem data
      List<int> imageBytes = _imageFile.readAsBytesSync();
      var contentType = _imageFile.path.split(".").last;
      String header = 'data:image/$contentType;base64,';
      String base64Image = base64Encode(imageBytes);
      String imageDataURL = header+base64Image;
      colaborar.imagem = imageDataURL;

      colaborar.idServico = tipoColaboracao.id;
      colaborar.idOperador = AppSettings.user.idPessoa;
      colaborar.idSolicitante = AppSettings.user.idPessoa;
      colaborar.idSetor = tipoColaboracao.idSetor;
      await apiRest.postNewColaboracao(colaborar);

      setState(() {
        _saving = false;
      });
      _showDialog(apiRest.message);

    }else{
      _showSnackBar("Preencha os campos");
    }

  }

  List<Widget> _buildForm(BuildContext context) {
    Form form = Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: new ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            //botão para obter foto

            Ink(
              decoration: BoxDecoration(
                //border: Border.all(color: Colors.indigoAccent, width: 2),
                color: Colors.lightBlue,
                shape: BoxShape.circle,
              ),
              child: InkWell(
                //This keeps the splash effect within the circle
                borderRadius: BorderRadius.circular(1000.0),
                //Something large to ensure a circle
                onTap: getImage,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(
                    Icons.photo_camera,
                    size: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            //bairro
            DropdownFormField<String>(
              validator: (value) {
                if (value == null) {
                  return 'Selecione o Bairro';
                }
              },
              onSaved: (val) => colaborar.bairro = val,
              decoration: InputDecoration(
                icon: Icon(Icons.add_location),
                border: UnderlineInputBorder(),
               // filled: true,
                labelText: 'Bairro',
              ),
              initialValue: null,
              items: _bairros.map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),


            //Logradouro
            new TextFormField(
              onSaved: (val) => colaborar.rua = val,
              validator: (val) {
                return val.length < 3
                    ? "Digite o nome da sua rua"
                    : null;
              },
              decoration: const InputDecoration(
                icon: const Icon(Icons.location_on),
                hintText: 'Digite o nome da sua rua',
                labelText: 'Logradouro',
              ),
            ),

            new TextFormField(
              onSaved: (val) => colaborar.numero = int.tryParse(val),
              validator: (val) {
                return val.length < 3
                    ? "Digite o número da casa mais proxima do local"
                    : null;
              },
              decoration: const InputDecoration(
                icon: const Icon(Icons.location_on),
                hintText: 'Digite o número da casa mais proxima do local',
                labelText: 'Número',
              ),
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
              ],
            ),

            new TextFormField(
              onSaved: (val) => colaborar.descricao = val,
              validator: (val) {
                return val.length < 3
                    ? "Preencha com uma breve descrição"
                    : null;
              },
              decoration: const InputDecoration(
                icon: const Icon(Icons.comment),
                hintText: 'Preencha com uma breve descrição',
                labelText: 'Descrição',
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
            ),

            Container(
                padding: EdgeInsets.only(left: 0, top: 20.0),
                child: RaisedButton(
                  color: AppStyle.buttonPrimary,
                  child: Text('Colaborar'),
                  onPressed: _submit,
                )),
          ],
        ));

    var l = new List<Widget>();
    l.add(form);

    if (_saving) {
      l.add(modalProgressIndicator());
    }
    return l;
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    return Scaffold(
      appBar: new AppBar(
        title: new Text("Colaborar"),
        backgroundColor: AppStyle.backgroundDark,
        elevation: 0,
      ),
      key: _scaffoldKey,
      backgroundColor: AppStyle.backgroundDark, //#3b4455
      body: new Stack(
        children: _buildForm(context),
      ),
    );
  }
}
