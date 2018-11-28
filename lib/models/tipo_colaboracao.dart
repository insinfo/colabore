class TipoColaboracao {
  int id;
  String cor;
  String icone;
  String nome;
  String descricao;
  int idSetor;

  TipoColaboracao(
      {this.id, this.cor, this.icone, this.nome, this.descricao, this.idSetor});

  TipoColaboracao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cor = json['cor'];
    icone = json['icone'];
    nome = json['nome'];
    descricao = json['descricao'];
    idSetor = json['idSetor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cor'] = this.cor;
    data['icone'] = this.icone;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['idSetor'] = this.idSetor;
    return data;
  }
}
