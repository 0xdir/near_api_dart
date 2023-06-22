import 'package:test/test.dart';
import 'package:near_api_dart/near_api_dart.dart';

void main() async {
  test("Get details of a specific chunk", () async {
    String rpcURL = 'https://rpc.testnet.near.org';
    Near near = Near();
    JsonRpcProvider rpc = near.providers.jsonRpcProvider(rpcURL);
    rpc
        .chunkDetails(
          chunkId: 'EBM2qg5cGr47EjMPtH88uvmXHDHqmWPzKaQadbWhdw22',
        )
        .then((value) => expect(
              value,
              completes,
            ));
    rpc.close();
  });
}
