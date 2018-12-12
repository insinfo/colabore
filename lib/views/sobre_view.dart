import 'package:flutter/material.dart';
import 'package:colabore/widgets/diagonally_cut_colored_image.dart';
import 'package:colabore/app_settings.dart';
import 'package:colabore/style.dart';

class SobreView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new SobreViewState();
  }
}

class SobreViewState extends State<SobreView> {
  BuildContext _ctx;
  static const BACKGROUND_IMAGE = 'assets/profile_header_background.png';

  Widget _buildDiagonalImageBackground(BuildContext context) {
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

  Widget _buildAvatar() {
    return Container(
      width: double.infinity,
      height: 150,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Image.asset('assets/jubarteLogo.png'),
    );
  }

  Widget _buildUserInfo(TextTheme textTheme) {
    var followerStyle =
        textTheme.subhead.copyWith(color: const Color(0xBBFFFFFF));

    return new Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(AppSettings.user.loginName, style: followerStyle),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
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

  Widget _buildTextBlock(String text,
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
        backgroundColor: Color.fromRGBO(255, 255, 255, 1), //#3b4455
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            _header(context),
            _buildTextBlock("Desenvolvido pela COTINF",
                fontWeight: FontWeight.bold,fontSize: 14),
            _buildTextBlock("Coordenadoria de Tecnologia de Informação\r\nPrefeitura de Rio das Ostras",
                fontWeight: FontWeight.normal,fontSize: 12),
            _buildTextBlock("Coordenador",
                fontWeight: FontWeight.bold,fontSize: 14),
            _buildTextBlock("Roger Gomes\r\n",
                fontWeight: FontWeight.normal,fontSize: 14),
            _buildTextBlock("Equipe de Desenvolvimento",
                fontWeight: FontWeight.bold,fontSize: 14),
            _buildTextBlock(
                    "Leonardo Calheiros Oliveira\r\n" +
                    "Gabriel Bruno de Oliveira Mendonça\r\n" +
                    "Isaque Neves Sant'Ana\r\n" +
                    "José Amaro da Costa Neto\r\n" +
                    "Cintia Maria Pimentel Hermida dos Santos\r\n",
                fontWeight: FontWeight.normal,fontSize: 12),

            _buildTextBlock("Projeto Piloto/Colaborador",
                fontWeight: FontWeight.bold,fontSize: 14),
            _buildTextBlock("Eduardo de Souza Bernardino da Silva\r\nEduardo Medeiros Delgado Rimes",
                fontWeight: FontWeight.normal,fontSize: 12),

            _buildTextBlock("Se chama Jubarte por quê?",
                fontWeight: FontWeight.bold,fontSize: 14),
            _buildTextBlock(
              "No início o projeto, que era bem menor, se chamava Novo Ciente. Era basicamente um sistema de abertura de boletins. Porém percebemos que várias funcionalidades necessitavam de muitas informações que não existiam de maneira organizada em nenhum tipo único de banco de dados.\r\n\r\n" +
                  "Sendo assim, foi preciso unificar as bases de dados e desenvolver sistemas para criação e manutenção desse novo Banco.\r\n\r\n" +
                  "Durante toda a implementação nos deparamos com situações conflitantes porque estávamos utilizando diversas tecnologias em conjunto, o que nos obrigou a desenvolver algumas API's.\r\n\r\n" +
                  "O projeto já estava enorme e foi divido em 3 fases de conclusões e entregas para que mais pessoas pudessem participar. A equipe concordou que a plataforma merecia um novo nome. Levando em conta a história da cidade e também pensando em um plataforma de peso que englobava outros sistemas, surgiu o nome Jubarte!",
                fontSize: 12
            ),
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
        )));
  } //fim metodo build
}
