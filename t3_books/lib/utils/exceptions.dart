class ConnectivityErrorEx implements Exception {
  String cause;
  ConnectivityErrorEx(this.cause);
}

class NoBookFoundEx implements Exception {}
