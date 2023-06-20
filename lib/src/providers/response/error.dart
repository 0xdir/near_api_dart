import 'dart:convert';

/// Thrown when the server returns an error in the RPC reponse.
class RPCError implements Exception {
  final dynamic error;
  late String errorName;
  late String causeName;
  late String info;

  RPCError(this.error) {
    errorName = error['name'];
    causeName = error['cause']['name'];
    info = json.encode(error['cause']['info']);
  }

  @override
  String toString() {
    return 'RPCError: got code $errorName with msg $causeName. $info';
  }
}
