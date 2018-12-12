import 'package:colabore/app_settings.dart';
class Usuario{

  int expiresIn;
  String accessToken;
  String fullName;
  String loginName;
  int idPessoa;
  int idOrganograma;
  int idPerfil;
  String imagemPessoa;
  String cpfPessoa;

  Usuario({
    this.expiresIn,
    this.accessToken,
    this.fullName,
    this.loginName,
    this.idPessoa,
    this.idOrganograma,
    this.idPerfil,
    this.imagemPessoa,
    this.cpfPessoa,
  });

  Usuario.empty();

  static Usuario fromJson(Map<String,dynamic> json){
    return Usuario(
      expiresIn: json['expiresIn'],
      accessToken: json['accessToken'],
      fullName: json['fullName'],
      loginName: json['loginName'],
      idPessoa: json['idPessoa'],
      idOrganograma: json['idOrganograma'],
      idPerfil: json['idPerfil'],
      imagemPessoa: json['imagemPessoa'],
      cpfPessoa: json['cpfPessoa'],
    );
  }

  String get avatarUrl{
    if(imagemPessoa == null || imagemPessoa == ""){
      return null;//"https://jubarte.riodasostras.rj.gov.br/cdn/Assets/icons/userNoImage.jpg";
    }
    var url = AppSettings.webServiceBaseURL+imagemPessoa;
    return url;
  }

  Map<String, dynamic> toJson() => {
    'expiresIn': expiresIn,
    'accessToken': accessToken,
    'fullName': fullName,
    'loginName': loginName,
    'idPessoa': idPessoa,
    'idOrganograma': idOrganograma,
    'idPerfil': idPerfil,
    'imagemPessoa': imagemPessoa,
    'cpfPessoa': cpfPessoa,
  };
}