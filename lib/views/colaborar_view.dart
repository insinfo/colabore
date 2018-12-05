import 'dart:ui';
import 'package:flutter/material.dart';

class ColaborarView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ColaborarViewState();
  }
}

class ColaborarViewState extends State<ColaborarView> {
  BuildContext _ctx;

  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    return Scaffold(
        appBar: null,
        key: _scaffoldKey,
        backgroundColor: Color(0xFF3b4455), //#3b4455
        body: SingleChildScrollView(
            child: Form(key: _formKey,
                child: Column(children: <Widget>[
                  Text("asdas"),
                ])
            )
        )
    );
  } //fim metodo build
}
