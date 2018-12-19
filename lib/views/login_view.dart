import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:colabore/data/database_helper.dart';
import 'package:colabore/models/usuario.dart';

import 'package:colabore/style.dart';
import 'package:colabore/services/auth_service.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginViewState();
  }
}

class LoginViewState extends State<LoginView> {
  BuildContext _ctx;
  bool _isLoading = false;
  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _username, _password;
  bool _isLogged = false;

  @override
  void initState()  {
    super.initState();
    isLogged();
  }

  Future isLogged() async {
    var db = new DatabaseHelper();
    var isLoggedIn = await db.isLoggedIn();
    if(isLoggedIn)
    {
      Navigator.of(context).pushReplacementNamed("/home");
    }else{

      setState(() {
        _isLogged = true;
      });
    }
  }

  Future _submit() async {
    final form = _formKey.currentState;

    if (form.validate()) {
      setState(() => _isLoading = true);
      form.save();

      AuthService authService = new AuthService();
      var user = await authService.doLogin(_username, _password);
      if(user != null) {
        _showSnackBar("Bem vindo " + user.fullName);
        setState(() => _isLoading = false);
        var db = new DatabaseHelper();
        await db.deleteUsers();
        await db.saveUser(user);
        Navigator.of(context).pushReplacementNamed("/home");
      }else{
        setState(() => _isLoading = false);
        _showSnackBar(authService.message);
      }

    }
  }

  void _showSnackBar(String text) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  Widget buildLoginView(BuildContext context) {

    final logo = Padding(
      padding: EdgeInsets.fromLTRB(70, 16, 70, 16),
      child: Image.asset('assets/jubarteLogo.png'),
    );

    final email = TextFormField(
      onSaved: (val) => _username = val,
      validator: (val) {
        return val.length < 10
            ? "O nome de usuário deve ter pelo menos 10 caracteres"
            : null;
      },
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      style: TextStyle(
        color: Colors.white,
      ),
      //initialValue: 'teste@teste.com',
      decoration: InputDecoration(
        // labelText:'Email',
        //   labelStyle: TextStyle(color: Colors.white)
        hintText: 'Email', hintStyle: TextStyle(color: Color(0xFF7887A4)),
        // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(3.0)),
      ),
    );

    final password = TextFormField(
      onSaved: (val) => _password = val,
      validator: (val) {
        return val.length < 2
            ? "Você tem que digitar a senha."
            : null;
      },
      autofocus: false,
      //initialValue: '123456',
      obscureText: true,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        //labelText:'Senha',labelStyle: TextStyle(color: Colors.white),
        hintText: 'Senha',hintStyle: TextStyle(color: Color(0xFF7887A4)),
        // contentPadding: EdgeInsets.fromLTRB(3, 3, 3, 3),
        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(3.0)),
      ),
    );

    //botão entrar
    final loginBtn = Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                child:  SizedBox(
                  width: double.infinity,
                  height: 40,
                  child:  RaisedButton(
                    onPressed: () {
                      _submit();
                    },
                    color: AppStyle.buttonBlue, //#5fd0d0
                    child: Text('ENTRAR', style: TextStyle(color: Colors.white)),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
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
                  child: CircularProgressIndicator()
              )
            ],
          ),
        ),
      ],
    );

    return Scaffold(
        appBar: null,
        key: _scaffoldKey,
        backgroundColor: Color(0xFF3b4455),//#3b4455
        body: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                  ) ,

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
                  ) ,

                  //input senha
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                              child: password,
                            )
                          ],
                        ),
                      ),
                    ],
                  ) ,

                  _isLoading ? loading : loginBtn,

                  //botão cadastrar
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(16, 5, 16, 0),
                              child:  SizedBox(
                                width: double.infinity,
                                height: 40,
                                child:  RaisedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/cadastro');
                                  },
                                  color: Color(0xFF71db9c), //#5fd0d0
                                  child: Text('CADASTRAR', style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),


                  //botão recuperar senha
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(16,25, 16, 0),
                              child:  SizedBox(
                                  width: double.infinity,
                                  height: 40,
                                  child:  FlatButton(
                                    child: Text(
                                      'Esqueceu sua senha?',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pushNamed('/recuperarAcesso');
                                    },
                                  )
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ) ,

                  Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(125, 5, 125, 0),
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
              ),
            )



        )
    );


  }//fim metodo buildLoginView

  @override
  Widget build(BuildContext context) {
    _ctx = context;

   return _isLogged == false ? Scaffold(
     body: Center(
       //padding: EdgeInsets.fromLTRB(16, 5, 16, 16),
         child: CircularProgressIndicator()
     ),backgroundColor: AppStyle.backgroundDark,
   )
       : buildLoginView(context);

  }//fim metodo build
}