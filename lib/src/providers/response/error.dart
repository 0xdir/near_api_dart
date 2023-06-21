import 'dart:convert';
/// Thrown when there are is an error in the RPC response.
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
