import 'package:flutter/material.dart';
import 'package:colabore/widgets/diagonally_cut_colored_image.dart';
import 'package:colabore/app_settings.dart';
import 'package:colabore/style.dart';
import 'package:colabore/services/tipo_colaboracao_service.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

class PoliticaView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PoliticaViewState();
  }
}

class PoliticaViewState extends State<PoliticaView> {
  BuildContext _ctx;
  static const BACKGROUND_IMAGE = 'assets/profile_header_background.png';
  String _politica ='<body><p style="color:#00000;"><strong>Dental Assistants:</strong></p>';
  ColaboracaoService colaboracaoService = new ColaboracaoService();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future loadData() async{
    var r = await colaboracaoService.getTermos();
    setState(() {
      _politica = r;
    });
    print(_politica);

  }

  _buildDiagonalImageBackground(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return new DiagonallyCutColoredImage(
      new Image.asset(
        BACKGROUND_IMAGE,
        width: screenWidth,
        height: 280.0,
        fit: BoxFit.cover,
      ),
      color: Color.fromRGBO(30, 97, 145, .7),
    );
  }

  _buildAvatar() {
    return Container(
      width: double.infinity,
      height: 150,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Image.asset('assets/jubarteLogo.png'),
    );
  }

  _header(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return new Stack(
      children: <Widget>[
        _buildDiagonalImageBackground(context),
        new Align(
          alignment: FractionalOffset.bottomCenter,
          heightFactor: 1.4,
          child: new Column(
            children: <Widget>[
              _buildAvatar(),
            ],
          ),
        ),
        new Positioned(
          top: 26.0,
          left: 4.0,
          child: new BackButton(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  _buildTextBlock(String text,
      {FontWeight fontWeight = FontWeight.normal,
      double fontSize = 16,
      int maxLines = 100}) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
      child: Row(children: <Widget>[
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines,
            style: TextStyle(
                color: AppStyle.textDark,
                fontSize: fontSize,
                fontWeight: fontWeight),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    return Scaffold(
        appBar: null,
        backgroundColor: Color.fromRGBO(20, 20, 20, 1), //#3b4455
        body: SingleChildScrollView(
          child: Column(
            children:
            <Widget>[
              _header(context),
              Container(
                width: double.infinity,
                child: new HtmlView(
                  data: _politica,
                  baseURL: "", // optional, type String
                  onLaunchFail: (url) { // optional, type Function
                  print("launch $url failed");
                }
                ),
              ),
            ]
          )
        ),


          /*child: new HtmlView(
            data: _politica,
            //baseURL: "", // optional, type String
            /*onLaunchFail: (url) { // optional, type Function
            print("launch $url failed");
          }*/
          ),*/


        /*SingleChildScrollView(
            child: Column(
          children: <Widget>[
            _header(context),

            _buildTextBlock(_politica,
                fontWeight: FontWeight.normal,fontSize: 12),

            SizedBox(height: 50,),

            Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(125, 5, 125, 0),
                  child: Image.asset('assets/logo-pmro-2018-cinza.png'),
                )
            ),

            Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(120, 5, 120, 50),
                  child: Text("Desenvolvido pela COTINF",
                    style: TextStyle(fontSize: 12,color: AppStyle.textDark),
                  ),
                )
            ),
          ],
        )
        )*/


    );
  } //fim metodo build


}
