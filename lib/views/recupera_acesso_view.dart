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
  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _username;

  Future _submit() async {
    final form = _formKey.currentState;
  }

  void _showSnackBar(String text) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  _buildForm(BuildContext context) {
    final logo = Padding(
      padding: EdgeInsets.fromLTRB(70, 16, 70, 16),
      child: Image.asset('assets/jubarteLogo.png'),
    );

    final email = TextFormField(
      onSaved: (val) {},
      validator: (val) {
        return val.length < 10 ? "digite o email usado no cadastro" : null;
      },
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      style: TextStyle(
        color: Colors.white,
      ),
      initialValue: '',
      decoration: InputDecoration(
        hintText: 'Email', hintStyle: TextStyle(color: Color(0xFF7887A4)),
      ),
    );


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

    return Scaffold(
        appBar: null,
        backgroundColor: Color(0xFF3b4455), //#3b4455
        body: SingleChildScrollView(
            child: Form(
          child: Column(
            children: <Widget>[
              //logo do app
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(25),
                          child: logo,
                        )
                      ],
                    ),
                  ),
                ],
              ),

              //input email
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                          child: email,
                        )
                      ],
                    ),
                  ),
                ],
              ),

              //botão recuperar
              Row(
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
                              onPressed: () {

                              },
                              color: Color(0xFF71db9c), //#5fd0d0
                              child: Text('RECUPERAR ACESSO',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              Center(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(125, 50, 125, 0),
                child: Image.asset('assets/pmro2018-logo.png'),
              )),

              Center(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(120, 2, 120, 50),
                child: Text(
                  "Desenvolvido pela COTINF",
                  style: TextStyle(fontSize: 10),
                ),
              )),
            ],
          ),
        )));
  } //fim metodo buildForm

  @override
  Widget build(BuildContext context) {
    return _buildForm(context);
  } //fim metodo build

}
