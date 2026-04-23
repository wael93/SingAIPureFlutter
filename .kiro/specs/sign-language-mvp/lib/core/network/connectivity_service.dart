import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  
  Stream<ConnectionStatus> get statusStream {
    return _connectivity.onConnectivityChanged.map((result) {
      if (result.contains(ConnectivityResult.none)) {
        return ConnectionStatus.offline;
      }
      return ConnectionStatus.online;
    });
  }
  
  Future<ConnectionStatus> checkConnection() async {
    final result = await _connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      return ConnectionStatus.offline;
    }
    return ConnectionStatus.online;
  }
  
  bool get isOnline {
    return !isOffline;
  }
  
  bool get isOffline {
    return _connectivity.checkConnectivity().then((result) {
      return result.contains(ConnectivityResult.none);
    }).catchError((_) => true);
  }
}

enum ConnectionStatus { online, offline }
