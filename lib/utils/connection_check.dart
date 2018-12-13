
import 'package:connectivity/connectivity.dart';
import 'dart:io';

class ConnectionCheck{

  static bool asInternet = false;

  static Future<bool> isInternet() async {
    var result = false;

    try {
      var connectivityResult = await (new Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        result = true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        result = true;
      }

      if(result) {
        final internet = await InternetAddress.lookup('google.com');
        if (internet.isNotEmpty && internet[0].rawAddress.isNotEmpty) {
          result = true;
        }
      }else{
        result = false;
      }

    }catch(e){
      result = false;
      return result;
    }
    return result;
  }
}