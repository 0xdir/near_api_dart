/// A helper class to parse the response from the RPC.
///
/// Contains the [error], if any, or [result].
class RPCResponse {
  final Map<String, dynamic> data;
  Map<String, dynamic> error = {};
  dynamic result = {};

  RPCResponse(this.data) {
    if (data.containsKey('error')) {
      error = data['error'];
    } else {
      result = data['result'];
    }
  }
}
