import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// Abstract interface for checking internet connection.
abstract interface class ConnectionChecker {
  /// Returns `true` if the device is connected to the internet.
  Future<bool> get isConnected;
}

/// Implementation of [ConnectionChecker] using InternetConnectionCheckerPlus.
class ConnectionCheckerImplementation implements ConnectionChecker {
  final InternetConnection internetConnection;

  /// Constructor to initialize with an [InternetConnection] instance.
  ConnectionCheckerImplementation(this.internetConnection);

  @override
  Future<bool> get isConnected async =>
      await internetConnection.hasInternetAccess; // Checks internet access.
}
