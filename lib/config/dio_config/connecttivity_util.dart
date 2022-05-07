// The connectivity plugin states in its docs that it only provides information if
// there is a network connection, but not if the network is connected to the
// Internet

// Note that on Android, this does not guarantee connection to Internet. For
// instance, the app might have wifi access but it might be a VPN or a hotel WiFi
// with no access. You can use

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityUtil {
  //This creates the single instance by calling the `_internal` constructor specified below
  static final ConnectivityUtil _singleton = ConnectivityUtil._internal();
  ConnectivityUtil._internal();
  //This is what's used to retrieve the instance through the app
  static ConnectivityUtil getInstance() => _singleton;
  //This tracks the current connection status
  bool _hasConnection = false;
  //This is how we'll allow subscribing to connection changes
  final StreamController connectionChangeController = StreamController();
  Stream get connectionChange => connectionChangeController.stream;
  //flutter_connectivity
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> listen() {
    return connectionListener().listen(_connectionChange);
  }

  bool get hasConnection => _hasConnection;

  //flutter_connectivity's listener
  void _connectionChange(ConnectivityResult result) {
    hasInternetInternetConnection();
  }

  Future<bool> hasInternetInternetConnection() async {
    bool previousConnection = _hasConnection;
    if (await hasConnectivity()) {
      //Check there is actual internet connection with a mobile network or wifi
      if (await InternetConnectionChecker().hasConnection) {
        // Network data detected & internet connection confirmed.
        _hasConnection = true;
      } else {
        // Network data detected but no internet connection found.
        _hasConnection = false;
      }
    }
    // device has no mobile network and wifi connection at all
    else {
      _hasConnection = false;
    }
    // The connection status changed send out an update to all listeners
    if (previousConnection != _hasConnection) {
      connectionChangeController.add(_hasConnection);
    }
    return _hasConnection;
  }

  Stream<ConnectivityResult> connectionListener() {
    return _connectivity.onConnectivityChanged;
  }

  Future<bool> hasConnectivity() async {
    var _connectivityResult = await _connectivity.checkConnectivity();
    //Check if device is just connect with mobile network or wifi
    if (_connectivityResult == ConnectivityResult.mobile) return true;
    if (_connectivityResult == ConnectivityResult.wifi) return true;
    return false;
  }
}
