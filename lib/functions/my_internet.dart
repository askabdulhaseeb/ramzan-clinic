import 'package:connectivity_plus/connectivity_plus.dart';

class MyInternet {
  Future<bool> isConnected() async {
    final ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else if (connectivityResult == ConnectivityResult.ethernet) {
      return true;
    } else if (connectivityResult == ConnectivityResult.vpn) {
      return true;
    } else if (connectivityResult == ConnectivityResult.bluetooth) {
      return false;
    } else if (connectivityResult == ConnectivityResult.other) {
      return false;
    } else if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return false;
  }
}
