import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:colabore/data/database_helper.dart';
import 'package:colabore/models/usuario.dart';

import 'package:colabore/style.dart';
import 'package:colabore/services/auth_service.dart';

class RecuperaAcessoView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecuperaAcessoViewState();
  }
}

class RecuperaAcessoViewState extends State<RecuperaAcessoView> {
  BuildContext _ctx;
  bool _isLoading = false;
  final _formKey1 = new GlobalKey<FormState>();
  final _formKey2 = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _email;
  String _novaSenha;
  String _repeteSenha;
  String _codigo;
  bool _etapa1 = false;
  AuthService authService = new AuthService();

  Future _salvarNovaSenha() async {
    final form = _formKey2.currentState;
    var aguard = await Future.delayed(const Duration(seconds: 1), () => "1");
    _showDialog("Operação Realizada Com Sucesso", onPressed: () {
      Navigator.of(context).pushNamed("/login");
    });
  }

  Future _requisitarNovaSenha() async {
    final form = _formKey1.currentState;
    form.save();

    setState(() {
      _isLoading = true;
    });

    print('_requisitarNovaSenha');

    var codigo = await authService.requisitarNovaSenha(_email);

    print(codigo);

    setState(() {
      _isLoading = false;
    });

    if (codigo == null) {
      _showDialog(authService.message, onPressed: () {
        //Navigator.of(_ctx).pushNamed("/login");
      });
    } else {
      setState(() {
        _etapa1 = true;
      });
    }
  }

  void _showDialog(String message, {Function onPressed}) {
    // flutter defined function
    showDialog(
      context: _ctx,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Atenção"),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
                if (onPressed != null) {
                  onPressed();
                }
                //Navigator.of(context).pushNamed("/home");
              },
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(String text) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  _buildLogo() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(25),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(70, 16, 70, 16),
                  child: Image.asset('assets/jubarteLogo.png'),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _buildBtn(String text, Function onPressed) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(16, 5, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: RaisedButton(
                    onPressed: onPressed,
                    color: AppStyle.buttonPrimary, //#5fd0d0
                    child: Text(text, style: TextStyle(color: Colors.white)),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _buildField(String hintText,
      {TextInputType keyboardType,
      Function onValida,
      Function onSaved,
      int maxLength,
      bool obscureText = false,
      String initialValue = ""}) {
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                padding: new EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: new TextFormField(
                  maxLength: maxLength,
                  onSaved: onSaved,
                  validator: onValida,
                  keyboardType: keyboardType,
                  autofocus: false,
                  style: new TextStyle(
                    color: AppStyle.textLight,
                  ),
                  initialValue: initialValue,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(color: AppStyle.textMedium),
                  ),
                  obscureText: obscureText,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  //progress
  final loading = Row(
    children: <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(16, 5, 16, 16),
                child: CircularProgressIndicator())
          ],
        ),
      ),
    ],
  );

  _buildFormRecovery() {
    var list = new List<Widget>();

    list.add(_buildLogo());

    list.add(new Row(
      children: <Widget>[
        new Expanded(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                padding: new EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: new TextFormField(
                  maxLength: 80,
                  onSaved: (val) {
                    _email = val;
                  },
                  //alidator: (val) {},
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                  style: new TextStyle(
                    color: AppStyle.textLight,
                  ),
                  //initialValue: '',
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: AppStyle.textMedium),
                  ),
                  obscureText: false,
                ),
              )
            ],
          ),
        ),
      ],
    ));

    if (_isLoading) {
      list.add(loading);
    } else {
      list.add(_buildBtn('RECUPERAR ACESSO', _requisitarNovaSenha));
    }

    return Form(
      key: _formKey1,
      autovalidate: false,
      child: Column(children: list),
    );
  } //fim metodo buildForm

  _buildFormRecovery2() {
    var list = new List<Widget>();
    list.clear();
    list.add(_buildLogo());
    list.add(Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: TextFormField(
                  maxLength: 6,
                  onSaved: (val) {
                    _codigo = val;
                  },
                  validator: (val) {},
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  style: TextStyle(
                    color: AppStyle.textLight,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Codigo',
                    hintStyle: TextStyle(color: AppStyle.textMedium),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ));

    list.add(Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: TextFormField(
                  maxLength: 6,
                  onSaved: (val) {},
                  validator: (val) {},
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  style: TextStyle(
                    color: AppStyle.textLight,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Nova Senha',
                    hintStyle: TextStyle(color: AppStyle.textMedium),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ));

    list.add(_buildBtn('SALVAR', _salvarNovaSenha));
    return Form(
      key: _formKey2,
      autovalidate: false,
      child: Column(children: list),
    );
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Recuperar Acesso"),
          backgroundColor: AppStyle.backgroundAppBar,
          elevation: 0,
        ),
        backgroundColor: AppStyle.backgroundDark,
        body: SingleChildScrollView(
          child:
              _etapa1 == false ? _buildFormRecovery() : _buildFormRecovery2(),
        ));
  } //fim metodo build

}
