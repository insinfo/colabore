import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:colabore/models/tipo_colaboracao.dart';
import 'package:colabore/style.dart';
import 'package:colabore/app_settings.dart';
import 'package:colabore/widgets/dropdown_form_field.dart';
import 'package:colabore/services/tipo_colaboracao_service.dart';
import 'package:colabore/widgets/modal_progress_indicator.dart';
import 'package:colabore/utils/utils.dart';
import 'package:colabore/utils/email_validator.dart';
import 'package:colabore/utils/birth_date_text_input_formatter.dart';
import 'package:colabore/models/cadastro_user_req.dart';

class CadastroView extends StatefulWidget {

  CadastroView({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new CadastroViewState();
  }
}

class CadastroViewState extends State<CadastroView> {
  BuildContext _ctx;

  List<String> _bairros = <String>['', 'red', 'green', 'blue', 'orange'];
  List<String> _sexos = <String>['Masculino', 'Feminino'];
  bool isAcceptedTerms = false;

  var cadastroUserReq = new CadastroUserReq();

  final senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    try {
      var bairros = await apiRest.getBairros();
      setState(() {
        _bairros = bairros;
      });
    }  catch (e) {
      print(e.message);
    }
  }

  bool _saving = false;
  bool _autoValidate = false;
  var apiRest = new ColaboracaoService();

  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showSnackBar(String text) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  void _showDialog(String message,{Function callback}) {
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
                if(callback != null){
                  callback();
                }
               // Navigator.of(context).pushNamed("/home");
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> _submit() async {

    final form = _formKey.currentState;

    /*if("" == null){
      _showSnackBar("Você não tirou uma foto!");
      return false;
    }*/

    if (form.validate()) {

      setState(() {
        _saving = true;
      });

      form.save();

      var mensagem ="";

      var result = await apiRest.postNewUser(cadastroUserReq);
      if(result != null){
        var necessarioAtivacao = result["necessarioAtivacao"];
        if(necessarioAtivacao == true){
          setState(() { _saving = false; });

          mensagem = "Detectamos que estes dados já esta cadastrado na nossa base de dados, entre no seu email: "+
          result["emailAtivacao"] +
          " para fazer a ativação do seu cadastro.";

          _showDialog(mensagem,callback: () async {

            Navigator.of(context).pushReplacementNamed("/login");

            const url = 'https://accounts.google.com/ServiceLogin?hl=pt-BR&passive=true&continue=https://www.google.com.br/';

            /*if (await canLaunch(url)) {
                await launch(url);
            }*/

          });
        }else{
          var use = await AppSettings.login(context, cadastroUserReq.pessoa.email, cadastroUserReq.usuario.senha);
          if(use == null){
            _showDialog("Erro ao logar automaticamente, tente logar");
            Navigator.of(context).pushReplacementNamed("/login");
          }
        }

      }else{
        mensagem = apiRest.message;
        setState(() { _saving = false; });
        _showDialog(mensagem);
      }

    }else{
      _showSnackBar("Preencha os campos");
    }
    return true;
  }

  List<Widget> _buildForm(BuildContext context) {
    Form form = Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[

            //bairro
           /* DropdownFormField<String>(
              validator: (value) {
                if (value == null) {
                  return 'Selecione o Bairro';
                }
              },
              //onSaved: (val) => teste = val,
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
            ),*/

            //CPF
            TextFormField(
               onSaved: (val) {
                 cadastroUserReq.pessoa.cpf = val;
                 print(cadastroUserReq.pessoa.cpf);
               },
              validator: (val) {
                return Utils.validarCPF(val)
                    ? null
                    : "Digite o seu CPF valido!";
              },
              decoration: InputDecoration(
                icon: Icon(Icons.picture_in_picture),
                hintText: 'Digite o seu CPF valido',
                labelText: 'CPF',
              ),
              keyboardType: TextInputType.number,
              //maxLength: 11,
              inputFormatters: [
                LengthLimitingTextInputFormatter(11),
                WhitelistingTextInputFormatter.digitsOnly,
              ],
            ),


            //telefone
            TextFormField(
              onSaved: (val) {
                cadastroUserReq.pessoa.telefone = val.trim();
              },
              validator: (val) {
                return val.trim().length < 8
                    ? "Digite o seu telefone com DDD!"
                    : null;
              },
              decoration: InputDecoration(
                icon: Icon(Icons.phone),
                hintText: 'Digite o telefone ex. 22997012222',
                labelText: 'Telefone',
              ),
              keyboardType: TextInputType.phone,
              //maxLength: 11,
              /*inputFormatters: [
                LengthLimitingTextInputFormatter(11),
                WhitelistingTextInputFormatter.digitsOnly,
              ],*/
            ),

            //email
            TextFormField(
              onSaved: (val) {
                cadastroUserReq.pessoa.email = val.trim();
              },
              decoration: InputDecoration(
                icon: Icon(Icons.mail),
                hintText: 'Digite o seu email valido',
                labelText: 'Email',
              ),
              validator: (val) => !EmailValidator.validate(val.trim(), true,true)
                  ? 'Não é um email válido!'
                  : null,

              keyboardType: TextInputType.emailAddress,
              //maxLength: 80,
              inputFormatters: [
                LengthLimitingTextInputFormatter(80),
              ],
            ),

            //nome
            TextFormField(
              onSaved: (val) {
                cadastroUserReq.pessoa.nome = val.trim();
              },
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Digite o seu nome completo',
                labelText: 'Nome',
              ),
              validator: (val) => val.trim().length < 11
                  ? 'O nome deve ter pelo menos 11 caracteres'
                  : null,

              keyboardType: TextInputType.text,
              //maxLength: 80,
              inputFormatters: [
                LengthLimitingTextInputFormatter(80),
              ],
            ),

            //data nascimento
            TextFormField(
              onSaved: (val) {
                cadastroUserReq.pessoa.dataNascimento = val.trim();
              },
              decoration: InputDecoration(
                icon: Icon(Icons.calendar_today),
                hintText: 'Digite a data de seu nascimento',
                labelText: 'Nascimento',
              ),
              validator: (val) => val.length < 10
                  ? 'Digite uma data valida!'
                  : null,

              keyboardType: TextInputType.datetime,
              //maxLength: 80,
              inputFormatters: [
                 LengthLimitingTextInputFormatter(80),
              ],
            ),

            //sexo
            DropdownFormField<String>(
              onSaved: (val) {
                cadastroUserReq.pessoa.sexo = val;
              },
              validator: (value) {
                if (value == null) {
                  return 'Selecione o sexo';
                }
              },
              decoration: InputDecoration(
                icon: Icon(Icons.find_replace),
                border: UnderlineInputBorder(),
                // filled: true,
                labelText: 'Sexo',
              ),
              initialValue: null,
              items: _sexos.map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            //senha
            TextFormField(
              controller: senhaController,
              onSaved: (val) {
                cadastroUserReq.usuario.senha = val;
              },
              decoration: InputDecoration(
                icon: Icon(Icons.vpn_key),
                hintText: 'Digite uma senha para acesso',
                labelText: 'Senha',
              ),
              validator: (val)
              {
                return val.length < 8
                  ? 'Digite uma senha com 8 caracteres!'
                  : null;
              },
              keyboardType: TextInputType.text,
              obscureText:true,
              //maxLength: 80,
              inputFormatters: [
                LengthLimitingTextInputFormatter(80),
              ],
            ),

            //repita senha
            TextFormField(
              onSaved: (val) {
                cadastroUserReq.usuario.resenha = val;
              },
              decoration: InputDecoration(
                icon: Icon(Icons.vpn_key),
                hintText: 'Repita a senha para acesso',
                labelText: 'Repita a Senha',
              ),
              validator: (val)
              {
                if(val.length < 8){
                  return 'Digite uma senha com 8 caracteres!';
                }else if(val != senhaController.text){
                  return 'As senhas não são igauis!';
                }else{
                  return null;
                }
              },
              keyboardType: TextInputType.text,
              obscureText:true,
              //maxLength: 80,
              inputFormatters: [
                LengthLimitingTextInputFormatter(80),
              ],
            ),

            //aceitar os termos
            CheckboxListTile(
              value: isAcceptedTerms,
              onChanged:(val){
                setState(() {
                  if(isAcceptedTerms == true){
                    isAcceptedTerms = false;
                  }else {
                    isAcceptedTerms = true;
                  }
                  cadastroUserReq.termos = "on";//isAcceptedTerms; //? 1 : 0;
                  print(cadastroUserReq.termos);
                });
              },
              title: new Text('Aceitar os termos'),
              controlAffinity: ListTileControlAffinity.leading,
             // subtitle: new Text('Subtitle'),
             // secondary: new Icon(Icons.archive),
             // activeColor: Colors.red,
            ),

            //botão
            Container(
                padding: EdgeInsets.only(left: 0, top: 10.0,bottom: 20),
                child: RaisedButton(
                  color: AppStyle.buttonPrimary,
                  child: Text('Cadastrar'),
                  onPressed:(){ _submit(); } ,
                )
            ),


            Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(120, 5, 120, 0),
                  child: Image.asset('assets/pmro2018-logo.png'),
                )
            ),

            Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(115, 2, 115, 50),
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
        title: new Text("Cadastrar"),
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

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    senhaController.dispose();
    super.dispose();
  }

      /*new TextFormField(
        decoration: const InputDecoration(
          icon: const Icon(Icons.person),
          hintText: 'Digite seu nome e sobrenome',
          labelText: 'Nome',
        ),
      ),
      new TextFormField(
        decoration: const InputDecoration(
          icon: const Icon(Icons.calendar_today),
          hintText: 'Enter your date of birth',
          labelText: 'Dob',
        ),
        keyboardType: TextInputType.datetime,
      ),
      new TextFormField(
        decoration: const InputDecoration(
          icon: const Icon(Icons.phone),
          hintText: 'Enter a phone number',
          labelText: 'Phone',
        ),
        keyboardType: TextInputType.phone,
        inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly,
        ],
      ),
      new TextFormField(
        decoration: const InputDecoration(
          icon: const Icon(Icons.email),
          hintText: 'Enter a email address',
          labelText: 'Email',
        ),
        keyboardType: TextInputType.emailAddress,
      ),

      new Container(
          padding: const EdgeInsets.only(left: 40.0, top: 20.0),
          child: new RaisedButton(
            child: const Text('Submit'),
            onPressed: null,
          )),
    */

}