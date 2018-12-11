//objeto para criar uma nova colaboração
class Colaborar {
  var prioridade = 2;
  var idOrganograma = 1;
  var idSolicitante = 3;
  var idSolicitanteSec = 3;
  var idEquipamento = 3;
  var idOperador = 21;
  var idSetor = 22;
  var idServico = 6;
  String descricao = "";
  String observacao = "";
  var status = 1;
  String imagem = "";
  String imagemPath;

  double latitude = 123.1233;
  double longitude = 2345.23489;
  String bairro = "";
  String rua = "";
  var numero = 624;

  /*{
    this.prioridade,
    this.idOrganograma,
    this.idSolicitante,
    this.idSolicitanteSec,
    this.idEquipamento,
    this.idOperador,
    this.idSetor,
    this.idServico,
    this.descricao,
    this.observacao,
    this.status,
    this.imagem,
    this.latitude,
    this.longitude,
    this.bairro,
    this.rua,
    this.numero,
  }*/

  Colaborar();

  Colaborar.fromJson(Map<String, dynamic> json) {
    this.prioridade = json['prioridade'];
    this.idOrganograma = json['idOrganograma'];
    this.idSolicitante= json['idSolicitante'];
    this.idSolicitanteSec= json['idSolicitanteSec'];
    this.idEquipamento= json['idEquipamento'];
    this.idOperador= json['idOperador'];
    this.idSetor= json['idSetor'];
    this.idServico= json['idServico'];
    this.descricao= json['descricao'];
    this.observacao= json['observacao'];
    this.status= json['status'];
    this.imagem= json['imagem'];
    this.latitude= json['latitude'];
    this.longitude= json['longitude'];
    this.bairro= json['bairro'];
    this.rua= json['rua'];
    this.numero= json['numero'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['prioridade'] = this.prioridade ;
    json['idOrganograma'] = this.idOrganograma;
    json['idSolicitante'] = this.idSolicitante;
    json['idSolicitanteSec'] = this.idSolicitanteSec;
    json['idEquipamento'] = this.idEquipamento;
    json['idOperador'] = this.idOperador;
    json['idSetor'] = this.idSetor;
    json['idServico'] = this.idServico;
    json['descricao'] = this.descricao;
    json['observacao'] = this.observacao;
    json['status'] = this.status;
    json['imagem'] = this.imagem;
    json['latitude'] = this.latitude;
    json['longitude'] = this.longitude;
    json['bairro'] = this.bairro;
    json['rua'] =this.rua;
    json['numero'] = this.numero;
    return json;
  }
}
