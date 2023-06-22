import 'package:test/test.dart';
import 'package:near_api_dart/near_api_dart.dart';

void main() async {
  test("View access key changes (all)", () async {
    String rpcURL = 'https://rpc.testnet.near.org';
    Near near = Near();
    JsonRpcProvider rpc = near.providers.jsonRpcProvider(rpcURL);
    rpc.viewAccessKeyChangesAll([
      'example-acct.testnet',
    ]).then((value) => expect(
          value,
          completes,
        ));
    rpc.close();
  });
}
