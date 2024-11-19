// هذا طريقه ب استخدام مكتبه جاخزة
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get onConnectionChanged;
}

class NetworkInfoImpl implements NetworkInfo {




  final InternetConnectionChecker _internetConnectionChecker = InternetConnectionChecker();

  @override
  Future<bool> get isConnected => _internetConnectionChecker.hasConnection;

  @override
  Stream<bool> get onConnectionChanged {
    return _internetConnectionChecker.onStatusChange.map((status) {
      return status == InternetConnectionStatus.connected;
    });
  }



  
}

//  internet_connection_checker هذا طريقه مباشرة بدون مكتبه
// import 'dart:io';

// abstract class NetworkInfo {
//   Future<bool> get isConnected;
//   Future<bool> checkInternet();
// }

// class NetworkInfoImpl implements NetworkInfo {
//   @override
//   Future<bool> get isConnected => checkInternet();

//   @override
//   Future<bool> checkInternet() async {
//     try {
//       // return true;
//       var result = await InternetAddress.lookup('google.com');
//       if ((result.isNotEmpty && result[0].rawAddress.isNotEmpty)) {
//         return true;
//       }
//     } on SocketException {
//       return false;
//     }
//     return false;
//   }
// }
