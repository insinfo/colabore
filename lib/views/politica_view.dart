import 'package:flutter/material.dart';
import 'package:colabore/widgets/diagonally_cut_colored_image.dart';
import 'package:colabore/app_settings.dart';
import 'package:colabore/style.dart';

class PoliticaView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return new PoliticaViewState();
  }
}

class PoliticaViewState extends State<PoliticaView> {
  BuildContext _ctx;
  static const BACKGROUND_IMAGE = 'assets/profile_header_background.png';
  String politica =
 "Esta política de privacidade rege o uso do aplicativo Jubarte, para dispositivos móveis criado pela Prefeitura de Rio das Ostras. O Jubarte App é uma aplicação de software para auxiliar a gestão do município por parte dos munícipes, isto é feito através de colaborações efetuadas a partir de serviços disponibilizados via app, como por exemplo “Coleta de galhada”, “Troca de lâmpada com defeito” e “Tapa buraco”, o usuário selecione o serviço preenche um pequeno formulário com informações como bairro, rua e tira uma foto do local, neste mesmo formulário o app obtém as coordenadas do usuário e envia para o sistema “Ciente” que é o sistema de gestão de tarefas da Prefeitura de Rio das Ostras, assim que a tarefa chega no sistema uma notificação é apresentada para o servidor público responsável por coordenar a execução daquele tipo de serviço selecionado pelo usuário do app, a partir deste momento basta o usuário aguardar para que o status da colaboração seja modificado para que ele saiba se a execução do serviço foi executada ou por motivo de força maior não pode ser realizado, assim o cidadão torna-se parte integrante do processo de administração da nossa cidade.\r\n"
+
  "\r\nQuais informações o Aplicativo obtém e como elas serão usadas?\r\n"
+
  "\r\nInformações fornecidas pelo usuário\r\n\r\n"
+
  "\r\nO Jubarte App, solicita informações no momento de registro da sua conta de usuário e também quando são realizadas colaborações. Os dados solicitados nesses momentos são obrigatórios.\r\n Eles serão enviados para nossos servidores, onde estarão guardados com toda infraestrutura e segurança necessárias.\r\n"
+
 "\r\nQuando você se registrar conosco e usar o Aplicativo, você fornecerá os seguintes dados:\r\n"
+
 "(a) cpf, telefone, email, nome completo, data de nascimento, sexo e senha; e ainda outras informações;"
  +"(b) informações que você nos fornece quando nos contata para obter ajuda;\r\n"
  +"(c) informações no momento da colaboração:  bairro, logradouro, número, longitude, latitude, foto e descrição.\r\n"

  +"Os dados fornecidos por você poderão ser utilizados pela Prefeitura Municipal de Rio das Ostras, para contatos posteriores. A fim de avisar ou notificar sobre algo que julgar importante.\r\n\r\n"

  +"Coleta automática de informações\r\n\r\n"
  +"Além disso, o Aplicativo pode coletar determinadas informações automaticamente, incluindo, mas não limitado a localização, o tipo de dispositivo móvel usado, o ID de dispositivo exclusivo de dispositivos móveis, o endereço IP de seu dispositivo móvel, o sistema operacional do celular, o tipo de celular Navegadores de Internet que você usa e informações sobre como você usa o Aplicativo.\r\n"
  +"O Aplicativo coleta informações precisas de localização em tempo real do dispositivo?"
  +"Quando você visita o aplicativo móvel, podemos usar a tecnologia GPS (ou outra tecnologia similar) para determinar sua localização atual, a fim de determinar a localização da colaboração com exatidão e outros dados que você deverá cadastrar como: cidade, bairro, rua, etc em que você está localizado e exibir um mapa de localização com anúncios relevantes da Prefeitura. Não compartilharemos sua localização atual com outros usuários ou parceiros.\r\n"
  +"Os terceiros veem e/ou têm acesso às informações obtidas pelo Aplicativo?"
  +"Sim. Nós compartilharemos suas informações com terceiros apenas das formas descritas nesta declaração de privacidade.\r\n"
  +"Podemos divulgar informações fornecidas e coletadas automaticamente pelo usuário:"
  +"- conforme exigido por lei, como para cumprir uma intimação ou processo legal semelhante;"
  +"- quando acreditamos de boa fé que a divulgação é necessária para proteger nossos direitos, proteger sua segurança ou a segurança de outras pessoas, investigar fraudes ou responder a uma solicitação do governo;\r\n"
  +"- com nossos prestadores de serviços confiáveis que trabalham em nosso nome, não têm um uso independente das informações que divulgamos a eles e concordamos em aderir às regras estabelecidas nesta declaração de privacidade.\r\n"
  +"Quais são os meus direitos de não colaborar mais?\r\n\r\n"
  +"Você pode parar toda a coleta de informações pelo Aplicativo facilmente, desinstalando o Aplicativo. Você pode usar os processos de desinstalação padrão que podem estar disponíveis como parte de seu dispositivo móvel ou via mercado ou rede de aplicativos móveis.\r\n"
  +"Política de Retenção de Dados, Gerenciando Suas Informações\r\n\r\n"
  +"Nós manteremos os dados fornecidos pelo usuário enquanto você usar o aplicativo e por um tempo razoável depois disso. Nós reteremos as informações coletadas automaticamente por até 24 meses e, a partir daí, poderemos armazená-las de forma agregada. Se desejar que excluamos os Dados fornecidos pelo usuário que você forneceu por meio do Aplicativo, entre em contato conosco pelo e-mail suporte@riodasostras.rj.gov.br e responderemos em um tempo razoável. Observe que alguns ou todos os dados fornecidos pelo usuário podem ser necessários para que o aplicativo funcione corretamente.\r\n"
  +"Crianças\r\n\r\n"
  +"Não utilizamos o Aplicativo para solicitar conscientemente dados de ou para menores de 13 anos. Se um pai ou responsável ficar ciente de que seu filho nos forneceu informações sem o consentimento deles, ele deverá entrar em contato conosco em suporte@riodasostras.rj.gov.br. Nós excluiremos essas informações de nossos arquivos em um tempo razoável.\r\n"
  +"Segurança\r\n\r\n"
  +"Estamos preocupados em proteger a confidencialidade de suas informações. Fornecemos proteções físicas, eletrônicas e processuais para proteger as informações que processamos e mantemos. \r\nPor exemplo, limitamos o acesso a essas informações a funcionários e contratados autorizados que precisam conhecer essas informações para operar, desenvolver ou melhorar nosso Aplicativo. Por favor, esteja ciente de que, embora nos empenhamos em fornecer segurança razoável para as informações que processamos e mantemos, nenhum sistema de segurança pode evitar todas as possíveis violações de segurança.\r\n"
  +"Alterar\r\n\r\n"
  +"Esta Política de Privacidade pode ser atualizada de tempos em tempos por qualquer motivo. Vamos notificá-lo de quaisquer alterações à nossa Política de Privacidade, publicando a nova Política de Privacidade aqui e informando-o via e-mail ou mensagem de texto. Recomenda-se que você consulte esta Política de Privacidade regularmente para quaisquer alterações, pois o uso continuado é considerado aprovação de todas as alterações. Você pode verificar o histórico desta política clicando aqui.\r\n"
  +"Sua permissão\r\n\r\n"
  +"Ao usar o Aplicativo, você está consentindo com o processamento de suas informações conforme estabelecido nesta Política de Privacidade agora e conforme alterado por nós. \"Processamento\" significa usar cookies em um computador / dispositivo portátil ou usar ou trocar informações de qualquer forma, incluindo, mas não se limitando a, coletar, armazenar, excluir, usar, combinar e divulgar informações, todas as quais atividades serão realizadas. No Brasil, se você reside fora do Brasil, suas informações serão transferidas, processadas e armazenadas de acordo com os padrões de privacidade do Brasil.\r\n"
  +"Contate-Nos\r\n\r\n"
  +"Se você tiver alguma dúvida sobre privacidade enquanto estiver usando o aplicativo ou tiver dúvidas sobre nossas práticas, entre em contato conosco por e-mail em suporte@riodasostras.rj.gov.br.\r\n";



  _buildDiagonalImageBackground(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return new DiagonallyCutColoredImage(
      new Image.asset(
        BACKGROUND_IMAGE,
        width: screenWidth,
        height: 280.0,
        fit: BoxFit.cover,
      ),
      color: Color.fromRGBO(30, 97, 145, .7),
    );
  }

  _buildAvatar() {
    return Container(
      width: double.infinity,
      height: 150,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Image.asset('assets/jubarteLogo.png'),
    );
  }

  _header(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return new Stack(
      children: <Widget>[
        _buildDiagonalImageBackground(context),
        new Align(
          alignment: FractionalOffset.bottomCenter,
          heightFactor: 1.4,
          child: new Column(
            children: <Widget>[
              _buildAvatar(),
            ],
          ),
        ),
        new Positioned(
          top: 26.0,
          left: 4.0,
          child: new BackButton(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  _buildTextBlock(String text,
      {FontWeight fontWeight = FontWeight.normal,
      double fontSize = 16,
      int maxLines = 100}) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
      child: Row(children: <Widget>[
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines,
            style: TextStyle(
                color: AppStyle.textDark,
                fontSize: fontSize,
                fontWeight: fontWeight),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    return Scaffold(
        appBar: null,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1), //#3b4455
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            _header(context),

            _buildTextBlock("Política de Privacidade & Termos",
                fontWeight: FontWeight.bold,fontSize: 14),

            _buildTextBlock(politica,
                fontWeight: FontWeight.normal,fontSize: 12),

            SizedBox(height: 50,),

            Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(125, 5, 125, 0),
                  child: Image.asset('assets/logo-pmro-2018-cinza.png'),
                )
            ),

            Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(120, 5, 120, 50),
                  child: Text("Desenvolvido pela COTINF",
                    style: TextStyle(fontSize: 12,color: AppStyle.textDark),
                  ),
                )
            ),
          ],
        )));
  } //fim metodo build


}
