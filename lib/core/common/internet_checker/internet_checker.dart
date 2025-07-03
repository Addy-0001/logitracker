import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logitracker_mobile_app/core/error/failure.dart';

class InternetChecker {
  Future<bool> hasConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
