import 'package:test/test.dart';
import 'package:near_api_dart/near_api_dart.dart';

void main() async {
  test("Get all access keys for an account", () async {
    String rpcURL = 'https://rpc.testnet.near.org';
    Near near = Near();
    JsonRpcProvider rpc = near.providers.jsonRpcProvider(rpcURL);
    String accountId = 'example.testnet';
    rpc.viewAccessKeyList(accountId).then((value) => expect(
          value,
          completes,
        ));
    rpc.close();
  });
}
