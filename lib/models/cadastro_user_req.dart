class CadastroUserReq {

  CadastroPessoa pessoa;
  CadastroUser usuario;
  String termos;

  CadastroUserReq(){
    pessoa = new CadastroPessoa();
    usuario = new CadastroUser();
    termos = "on";
  }

  CadastroUserReq.fromJson(Map<String, dynamic> json) {
    pessoa =
    json['pessoa'] != null ? new CadastroPessoa.fromJson(json['pessoa']) : null;
    usuario =
    json['usuario'] != null ? new CadastroUser.fromJson(json['usuario']) : null;
    termos = json['termos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pessoa != null) {
      data['pessoa'] = this.pessoa.toJson();
    }
    if (this.usuario != null) {
      data['usuario'] = this.usuario.toJson();
    }
    data['termos'] = this.termos;
    return data;
  }
}

class CadastroPessoa {
  String nome;
  String email;
  String cpf;
  String sexo;
  String dataNascimento;
  String telefone;

  CadastroPessoa({this.nome, this.email, this.cpf, this.sexo, this.dataNascimento});

  CadastroPessoa.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    email = json['email'];
    cpf = json['cpf'];
    sexo = json['sexo'];
    dataNascimento = json['dataNascimento'];
    telefone = json['telefone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['cpf'] = this.cpf;
    data['sexo'] = this.sexo;
    data['dataNascimento'] = this.dataNascimento;
    data['telefone'] = this.telefone;
    return data;
  }
}

class CadastroUser {
  String senha;
  String resenha;

  CadastroUser({this.senha, this.resenha});

  CadastroUser.fromJson(Map<String, dynamic> json) {
    senha = json['senha'];
    resenha = json['resenha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['senha'] = this.senha;
    data['resenha'] = this.resenha;
    return data;
  }
}