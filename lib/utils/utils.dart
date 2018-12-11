import 'dart:math';

class Utils {

  static List<int> randomizer(int size) {
    List<int> random = new List<int>();
    for (var i = 0; i < size; i++) {
      random.add(new Random().nextInt(9));
    }
    return random;
  }

  static String gerarCPF({bool formatted = false}) {
    List<int> n = randomizer(9);
    n..add(gerarDigitoVerificador(n))..add(gerarDigitoVerificador(n));
    return formatted ? formatCPF(n) : n.join();
  }

  static int gerarDigitoVerificador(List<int> digits) {
    int baseNumber = 0;
    for (var i = 0; i < digits.length; i++) {
      baseNumber += digits[i] * ((digits.length + 1) - i);
    }
    int verificationDigit = baseNumber * 10 % 11;
    return verificationDigit >= 10 ? 0 : verificationDigit;
  }

  static bool validarCPF(String cpf) {

    if(cpf == null){
      return false;
    }else if(cpf == ""){
      return false;
    }else if(cpf.length < 11){
      return false;
    }

    List<int> sanitizedCPF = cpf
        .replaceAll(new RegExp(r'\.|-'), '')
        .split('')
        .map((String digit) => int.parse(digit))
        .toList();

    if(blacklistedCPF(sanitizedCPF.join())){
      return false;
    }

    var result =
        sanitizedCPF[9] ==
            gerarDigitoVerificador(sanitizedCPF.getRange(0, 9).toList()) &&
        sanitizedCPF[10] ==
            gerarDigitoVerificador(sanitizedCPF.getRange(0, 10).toList());

    return result;
  }

  static bool blacklistedCPF(String cpf) {
    return
      cpf == '11111111111' ||
          cpf == '22222222222' ||
          cpf == '33333333333' ||
          cpf == '44444444444' ||
          cpf == '55555555555' ||
          cpf == '66666666666' ||
          cpf == '77777777777' ||
          cpf == '88888888888' ||
          cpf == '99999999999';
  }

  static String formatCPF(List<int> n) =>
      '${n[0]}${n[1]}${n[2]}.${n[3]}${n[4]}${n[5]}.${n[6]}${n[7]}${n[8]}-${n[9]}${n[10]}';


}