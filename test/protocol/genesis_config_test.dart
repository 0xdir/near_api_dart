import 'package:test/test.dart';
import 'package:near_api_dart/near_api_dart.dart';

void main() {
  test('Get genesis config', () {
    String rpcURL = 'https://rpc.testnet.near.org';
    Near near = Near();
    JsonRpcProvider rpc = near.providers.jsonRpcProvider(rpcURL);
    rpc.genesisConfig().then((value) => expect(
          value,
          completes,
        ));
    rpc.close();
  });
}
