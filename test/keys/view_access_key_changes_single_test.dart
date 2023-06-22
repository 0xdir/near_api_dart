import 'package:test/test.dart';
import 'package:near_api_dart/near_api_dart.dart';

void main() async {
  test("View access key changes (single)", () async {
    String rpcURL = 'https://rpc.testnet.near.org';
    Near near = Near();
    JsonRpcProvider rpc = near.providers.jsonRpcProvider(rpcURL);
    rpc.viewAccessKeyChangesSingle([
      {
        'account_id': 'example-acct.testnet',
        'public_key': 'ed25519:25KEc7t7MQohAJ4EDThd2vkksKkwangnuJFzcoiXj9oM'
      },
    ]).then((value) => expect(
          value,
          completes,
        ));
    rpc.close();
  });
}
