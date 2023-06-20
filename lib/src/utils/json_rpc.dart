import 'dart:convert';
import 'package:http/http.dart' as http;
import '../providers/response/response.dart';

/// A helper class which handles the RPC calls.
class JsonRPC {
  final String url;
  final http.Client client;

  JsonRPC(this.url, this.client);

  Future<RPCResponse> call(String method, dynamic params) async {
    final requestPayload = {
      'jsonrpc': '2.0',
      'id': 'dontcare',
      'method': method,
      'params': params,
    };

    final response = await client.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(requestPayload),
    );
    final Map<String, dynamic> data = json.decode(response.body);
    return RPCResponse(data);
  }

  void close() {
    client.close();
  }
}
