
class Colaboracao {
  int id;
  int ano;
  String numero;
  int idOrganograma;
  int idSolicitante;
  int idSolicitantesec;
  int idEquipamento;
  int idOperador;
  String descricao;
  String observacao;
  String dataAbertura;
  String dataFechamento;
  int prioridade;
  int atendimentoIni;
  int totalAtendimentos;
  int minStatus;
  String statusAtendimentos;
  String setorResponsavelSigla;
  String setorResponsavelNome;
  String siglaOrganograma;
  String nomeOrganograma;
  String nomeSolicitante;
  String cpfSolicitante;
  String historicoAtendimento;
  String idsAtendimento;
  String usuariosEnvolvidosAtendimento;
  String pessoasEnvolvidasHistorico;
  String idsUsuario;
  String idsSetorResponsavel;
  String latitude;
  String longitude;
  String bairro;
  String rua;
  String solicitacaoNumero;
 
  String get codigo{
    return this.ano.toString()+this.solicitacaoNumero.toString();
  }

  String get statusFinal{
    return listStatus[this.minStatus];
  }


  final listStatus = [
    "Aberto",
    "Em andamento",
    "Pendente",
    "Concluido",
    "Cancelado",
    "Duplicado",
    "Sem solução"
  ];

  Colaboracao(
      {this.id,
        this.ano,
        this.numero,
        this.idOrganograma,
        this.idSolicitante,
        this.idSolicitantesec,
        this.idEquipamento,
        this.idOperador,
        this.descricao,
        this.observacao,
        this.dataAbertura,
        this.dataFechamento,
        this.prioridade,
        this.atendimentoIni,
        this.totalAtendimentos,
        this.minStatus,
        this.statusAtendimentos,
        this.setorResponsavelSigla,
        this.setorResponsavelNome,
        this.siglaOrganograma,
        this.nomeOrganograma,
        this.nomeSolicitante,
        this.cpfSolicitante,
        this.historicoAtendimento,
        this.idsAtendimento,
        this.usuariosEnvolvidosAtendimento,
        this.pessoasEnvolvidasHistorico,
        this.idsUsuario,
        this.idsSetorResponsavel,
        this.latitude,
        this.longitude,
        this.bairro,
        this.rua,
        this.solicitacaoNumero});


  Colaboracao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ano = json['ano'];
    numero = json['numero'];
    idOrganograma = json['idOrganograma'];
    idSolicitante = json['idSolicitante'];
    idSolicitantesec = json['idSolicitantesec'];
    idEquipamento = json['idEquipamento'];
    idOperador = json['idOperador'];
    descricao = json['descricao'];
    observacao = json['observacao'];
    dataAbertura = json['dataAbertura'];
    dataFechamento = json['dataFechamento'];
    prioridade = json['prioridade'];
    atendimentoIni = json['atendimentoIni'];
    totalAtendimentos = json['totalAtendimentos'];
    minStatus = json['minStatus'];
    statusAtendimentos = json['statusAtendimentos'];
    setorResponsavelSigla = json['setorResponsavelSigla'];
    setorResponsavelNome = json['setorResponsavelNome'];
    siglaOrganograma = json['siglaOrganograma'];
    nomeOrganograma = json['nomeOrganograma'];
    nomeSolicitante = json['nomeSolicitante'];
    cpfSolicitante = json['cpfSolicitante'];
    historicoAtendimento = json['historicoAtendimento'];
    idsAtendimento = json['idsAtendimento'];
    usuariosEnvolvidosAtendimento = json['usuariosEnvolvidosAtendimento'];
    pessoasEnvolvidasHistorico = json['pessoasEnvolvidasHistorico'];
    idsUsuario = json['idsUsuario'];
    idsSetorResponsavel = json['idsSetorResponsavel'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    bairro = json['bairro'];
    rua = json['rua'];
    solicitacaoNumero = json['solicitacao_numero'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ano'] = this.ano;
    data['numero'] = this.numero;
    data['idOrganograma'] = this.idOrganograma;
    data['idSolicitante'] = this.idSolicitante;
    data['idSolicitantesec'] = this.idSolicitantesec;
    data['idEquipamento'] = this.idEquipamento;
    data['idOperador'] = this.idOperador;
    data['descricao'] = this.descricao;
    data['observacao'] = this.observacao;
    data['dataAbertura'] = this.dataAbertura;
    data['dataFechamento'] = this.dataFechamento;
    data['prioridade'] = this.prioridade;
    data['atendimentoIni'] = this.atendimentoIni;
    data['totalAtendimentos'] = this.totalAtendimentos;
    data['minStatus'] = this.minStatus;
    data['statusAtendimentos'] = this.statusAtendimentos;
    data['setorResponsavelSigla'] = this.setorResponsavelSigla;
    data['setorResponsavelNome'] = this.setorResponsavelNome;
    data['siglaOrganograma'] = this.siglaOrganograma;
    data['nomeOrganograma'] = this.nomeOrganograma;
    data['nomeSolicitante'] = this.nomeSolicitante;
    data['cpfSolicitante'] = this.cpfSolicitante;
    data['historicoAtendimento'] = this.historicoAtendimento;
    data['idsAtendimento'] = this.idsAtendimento;
    data['usuariosEnvolvidosAtendimento'] = this.usuariosEnvolvidosAtendimento;
    data['pessoasEnvolvidasHistorico'] = this.pessoasEnvolvidasHistorico;
    data['idsUsuario'] = this.idsUsuario;
    data['idsSetorResponsavel'] = this.idsSetorResponsavel;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['bairro'] = this.bairro;
    data['rua'] = this.rua;
    data['solicitacao_numero'] = this.solicitacaoNumero;
    return data;
  }



}