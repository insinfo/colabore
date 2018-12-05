import 'package:flutter/material.dart';
import 'package:colabore/widgets/diagonally_cut_colored_image.dart';
import 'package:colabore/app_settings.dart';

class PerfilView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new PerfilViewState();
  }
}

class PerfilViewState extends State<PerfilView> {
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
      color: const Color(0xBB8338f4),
    );
  }

  Widget _buildAvatar() {
    return new Hero(
      tag: "avatarTag",
      child: new CircleAvatar(
        backgroundImage: new NetworkImage(AppSettings.user.avatarUrl),
        radius: 50.0,
      ),
    );
  }

  Widget _buildUserInfo(TextTheme textTheme) {
    var followerStyle =
    textTheme.subhead.copyWith(color: const Color(0xBBFFFFFF));

    return new Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(AppSettings.user.loginName, style: followerStyle),
          new Text(
            ' | ',
            style: followerStyle.copyWith(
                fontSize: 24.0, fontWeight: FontWeight.normal),
          ),
          new Text(AppSettings.user.idPessoa.toString(), style: followerStyle),
        ],
      ),
    );
  }

  Widget _createPillButton(
      String text, {
        Color backgroundColor = Colors.transparent,
        Color textColor = Colors.white70,
      }) {
    return new ClipRRect(
      borderRadius: new BorderRadius.circular(30.0),
      child: new MaterialButton(
        minWidth: 140.0,
        color: backgroundColor,
        textColor: textColor,
        onPressed: () {},
        child: new Text(text),
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
              _buildUserInfo(textTheme),             
            ],
          ),
        ),
        new Positioned(
          top: 26.0,
          left: 4.0,
          child: new BackButton(color: Colors.white),
        ),
      ],
    );
  }
  

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    return Scaffold(
        appBar: null,
        backgroundColor: Color(0xFF3b4455),//#3b4455
        body: SingleChildScrollView(
            child: _header(context))


    );

  }//fim metodo build
}