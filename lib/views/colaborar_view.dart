import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:location/location.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'package:colabore/models/tipo_colaboracao.dart';
import 'package:colabore/style.dart';
import 'package:colabore/widgets/modal_progress_indicator.dart';
import 'package:colabore/services/tipo_colaboracao_service.dart';
import 'package:colabore/models/colaborar.dart';
import 'package:colabore/app_settings.dart';
import 'package:colabore/widgets/dropdown_form_field.dart';


class ColaborarView extends StatefulWidget {
  final TipoColaboracao tipoColaboracao;

  ColaborarView({Key key, @required this.tipoColaboracao}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new ColaborarViewState(tipoColaboracao: tipoColaboracao);
  }
}

class ColaborarViewState extends State<ColaborarView> {
  BuildContext _ctx;
  final TipoColaboracao tipoColaboracao;
  List<String> _bairros = <String>["Centro", "Ancora"];
  ColaboracaoService apiRest = new ColaboracaoService();

  Map<String, double> _startLocation;
  Map<String, double> _currentLocation;
  double latitude = -22.5272718;
  double longitude = -41.95030867;

  StreamSubscription<Map<String, double>> _locationSubscription;
  Location _location = new Location();
  bool _isLocationPermission = false;
  String error;
  bool _autoValidate = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();

  }

  _onLocationChange(Map<String, double> location) {
      _currentLocation = location;
      setState(() {
        print("onLocationChanged");
        latitude = location["latitude"] != null ? location["latitude"] : -22.5272718;
        longitude = location["longitude"] != null ? location["longitude"] : -41.95030867;
      });
  }

  @override
  void dispose(){
    super.dispose();
    _locationSubscription.cancel();
  }

  initPlatformState() async {
    Map<String, double> location;

    try {

      var bairros = await apiRest.getBairros();
      setState(() {
        _bairros = bairros;
      });

      _isLocationPermission = await _location.hasPermission();
      location = await _location.getLocation();
      setState(() {});
      _locationSubscription = _location.onLocationChanged().listen(_onLocationChange);
      _currentLocation = await _location.getLocation();
      setState(() {
        _startLocation = location;
        latitude = _currentLocation != null ? _currentLocation["latitude"] : -22.5272718;
        longitude = _currentLocation !=null ? _currentLocation["longitude"] : -41.95030867;
      });

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
  }

  ColaborarViewState({@required this.tipoColaboracao});

  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  var colaborar = new Colaborar();

  File _imageFile;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera,maxWidth: 640,maxHeight: 480,quality: 0.1);

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
                Navigator.of(context).pushNamed("/home");
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> _submit() async {
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
      return false;
    }

    setState(() => _isProcessing = true);

    if(_currentLocation == null){
      _showSnackBar("Você não autorizou o uso da localização!");
      return false;
    }

    if (form.validate()) {

      setState(() {
        _saving = true;
      });

      form.save();

      //obtem as coordenadas de GPS
      colaborar.latitude = _currentLocation["latitude"];
      colaborar.longitude = _currentLocation["longitude"];

      //obtem a imagem data URL
      /*List<int> imageBytes = await _imageFile.readAsBytes();
      var contentType = _imageFile.path.split(".").last;
      String header = 'data:image/$contentType;base64,';
      String base64Image = base64Encode(imageBytes);
      String imageDataURL = header+base64Image;
      colaborar.imagem = imageDataURL;*/
      colaborar.imagemPath = _imageFile.path;

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
    return true;
  }

  Widget _buildMap(BuildContext context) {

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

  _buildButtonTakePhoto(){
    return Ink(
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
    );
  }

  _buildPhotoPreview(){
    return Container(
      width: 150,height: 180,
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Image.file(_imageFile),
    );
  }

  List<Widget> _buildForm(BuildContext context) {
    Form form = Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            //botão para obter foto
            _imageFile == null ? _buildButtonTakePhoto() : _buildPhotoPreview(),

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
                return val.length < 1
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
              /*validator: (val) {
                return val.length < 3
                    ? "Preencha com uma breve descrição"
                    : null;
              },*/
              decoration: const InputDecoration(
                icon: const Icon(Icons.comment),
                hintText: 'Preencha com uma breve descrição',
                labelText: 'Descrição (opcional)',
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
            ),

            //mapa
            Container(
              width: 150,height: 180,
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: _buildMap(context),
            ),

            //botão
            Container(
                padding: EdgeInsets.only(left: 0, top: 20.0),
                child: RaisedButton(
                  color: AppStyle.buttonBlue,
                  child: Text('COLABORAR'),
                  onPressed: _submit,
                )
            ),


            Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(125, 50, 125, 0),
                  child: Image.asset('assets/pmro2018-logo.png'),
                )
            ),

            Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(120, 2, 120, 50),
                  child: Text("Desenvolvido pela COTINF",
                    style: TextStyle(fontSize: 10),
                  ),
                )
            ),



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
        //children: <Widget>[_buildMap(context),],
      ),
    );
  }


}
